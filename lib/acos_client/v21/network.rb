require 'acos_client/v21/base'


module AcosClient
  module V21

    class Network < AcosClient::V21::BaseV21

      def interface
        Interface.new(self.client)
      end

      class Interface < AcosClient::V21::BaseV21

        def all
          self._get('network.interface.getAll')
        end

        def get(port_num)
          # FIXME Broken ?
          self._get('network.interface.get', params: {:port_num => port_num})
        end

        def set(port_num, **otps)

          params = {
              :interface => {
                  :port_num => port_num
              }
          }
          self._post('network.interface.set', params: params, **opts)
        end

        def ipv4
          IPV4.new(self.client)
        end

        class IPV4 < AcosClient::V21::BaseV21

          def _set(action, port_num, ipv4_address, ipv4_mask, **opts)

            params = {
                :interface => {
                    :ipv4 => {
                        :ipv4_address => ipv4_address,
                        :ipv4_mask => ipv4_mask
                    },
                    :port_num => port_num
                }
            }

            self._post(action, params: params, **opts)
          end

          def all_delete(port_num, **opts)
            self._post('network.interface.ipv4.deleteAll', params: {:port_num => port_num}, **opts)
          end

          def add(port_num, ipv4_address, ipv4_mask, **opts)
            self._set('network.interface.ipv4.add', port_num, ipv4_address, ipv4_mask, **opts)
          end

          def delete(port_num, ipv4_address, ipv4_mask, **opts)
            self._set('network.interface.ipv4.delete', port_num, ipv4_address, ipv4_mask, **opts)
          end
        end
      end

      def acl
        ACL.new(self.client)
      end

      class ACL < AcosClient::V21::BaseV21

        def ext
          Ext.new(self.client)
        end

        class Ext < AcosClient::V21::BaseV21

          # Protocols
          ICMP = 0
          IP = 1
          TCP = 2
          UDP = 3

          def _set(action, id, acl_item_list, **opts)

            params = {
                :ext_acl => {
                    :id => id,
                    :acl_item_list => acl_item_list
                }
            }

            # silently fails if 'acl_item_list' is empty
            self._post(action, params: params, **opts)
          end

          def all
            self._get('network.acl.ext.getAll')
          end

          def search(id)
            # FIXME not working
            self._get('network.acl.ext.search', params: {:id => id})
          end

          def create(id, acl_item_list, **opts)
            self._set('network.acl.ext.create', id, acl_item_list, **opts)
          end

          def update(id, acl_item_list, **opts)
            self._set('network.acl.ext.update', id, acl_item_list,
                      **opts) # FIXME NOT WORKING
          end

          def delete(id)
            # FIXME NOT WORKING
            self._post('network.acl.ext.delete', params: {:id => id})
          end

          def all_delete(**opts)
            self._get('network.acl.ext.deleteAll', **opts)
          end
        end
      end

      def route
        Route.new(self.client)
      end

      class Route < AcosClient::V21::BaseV21

        def _set(action, address, mask, gateway, distance, **opts)
          params = {
              :address => address,
              :mask => mask,
              :gateway => gateway,
              :distance => distance
          }
          self._post(action, params: params, **opts)
        end

        def ipv4_all(**opts)
          self._get('network.route.ipv4static.getAll', **opts)
        end

        def ipv4_create(address, mask, gateway, distance, **opts)
          self._set('network.route.ipv4static.create', address, mask, gateway, distance, **opts)
        end

        def ipv4_update(address, mask, gateway, distance, **opts)
          # FIXME NOT WORKING
          self._set('network.route.ipv4static.update', address, mask, gateway, distance, **opts)
        end

        def ipv4_delete(address, mask, gateway, distance, **opts)
          # FIXME NOT WORKING
          self._set('network.route.ipv4static.delete', address, mask, gateway, distance, **opts)
        end
      end

    end

  end
end