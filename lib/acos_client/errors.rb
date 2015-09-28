module AcosClient
  module Error

    class Error < StandardError;
    end

    class ACOSUnsupportedVersion < Error;
    end

    class ACOSUnknownError < Error;
    end

    class AddressSpecifiedIsInUse < Error;
    end

    class AuthenticationFailure < Error;
    end

    class InvalidSessionID < Error;
    end

    class Exists < Error;
    end

    class NotFound < Error;
    end

    class NoSuchServiceGroup < Error;
    end

    class NotImplemented < Error;
    end

    class InUse < Error;
    end

    class InvalidPartitionParameter < Error;
    end

    class MemoryFault < Error;
    end

    class InvalidParameter < Error;
    end

    class OutOfPartitions < Error;
    end

    class PartitionIdExists < Error;
    end

    class HMMissingHttpPassive < Error;
    end

  end
end