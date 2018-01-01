Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbeAAMmy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 07:42:54 -0500
Date: Mon, 1 Jan 2018 12:42:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] docs: Add Simple Counter interface
 documentation
Message-ID: <20180101124249.478a28bf@archlinux>
In-Reply-To: <6a470b7e6576c6dcea7670d3b3f09e74368946e3.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
        <6a470b7e6576c6dcea7670d3b3f09e74368946e3.1513266127.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Dec 2017 15:51:55 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds high-level documentation about the Simple Counter
> interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
On small suggestion inline.

Jonathan
> ---
>  Documentation/driver-api/iio/index.rst          |   1 +
>  Documentation/driver-api/iio/simple-counter.rst | 393 ++++++++++++++++++++++++
>  2 files changed, 394 insertions(+)
>  create mode 100644 Documentation/driver-api/iio/simple-counter.rst
> 
> diff --git a/Documentation/driver-api/iio/index.rst b/Documentation/driver-api/iio/index.rst
> index e6c5b75c2e03..60e17f16cfb8 100644
> --- a/Documentation/driver-api/iio/index.rst
> +++ b/Documentation/driver-api/iio/index.rst
> @@ -16,3 +16,4 @@ Contents:
>     triggers
>     triggered-buffers
>     generic-counter
> +   simple-counter
> diff --git a/Documentation/driver-api/iio/simple-counter.rst b/Documentation/driver-api/iio/simple-counter.rst
> new file mode 100644
> index 000000000000..fa34f689e99f
> --- /dev/null
> +++ b/Documentation/driver-api/iio/simple-counter.rst
> @@ -0,0 +1,393 @@
> +========================
> +Simple Counter Interface
> +========================
> +
> +Introduction
> +============
> +
> +The most basic counter device may be expressed as a single Count
> +associated with a single Signal via a single Synapse. This is a popular
> +type of Counter implemented by hardware devices, and also what commonly
> +comes to mind when one thinks of a "counter device." This driver API
> +provides a basic Counter interface and standard of interaction and
> +exposure for these simple counter devices. The Simple Counter interface
> +enables drivers to support and expose simple counter devices in a more
> +apt and well-defined way, without the hassles and imprecisions of
> +utilizing a more generic interface.
> +
> +Theory
> +======
> +
> +The Simple Counter interface may be considered a subclass of the
> +Generic Counter interface; the same paradigm core components apply:
> +Counts, Signals, and Synapses. However, the Simple Counter interface
> +goes a bit further and defines aspects of those core components to
> +properly represent Simple Counter devices.
> +
> +The three core components of a Simple Counter:
> +
> +        COUNT
> +        -----
> +        A Count represents the count data for a set of Signals. The
> +        count data for a Simple Counter is a signed integer representing
> +        the accumulated count of Simple Signal action conditions.
> +
> +        A Count has a count function mode which represents the update
> +        behavior for the count data. The following two count function
> +        modes are possible for a Simple Count:
> +
> +                * Increase:
> +                        Accumulated count is incremented.
> +                * Decrease:
> +                        Accumulated count is decremented.
> +
> +        A Simple Count has one associated Simple Signal.
> +
> +        SIGNAL
> +        ------
> +        A Signal represents a counter input data; this is the data that
> +        is typically analyzed by the counter to determine the count
> +        data. A Simple Signal represents a counter input line with two
> +        possible states:
> +
> +                * Low
> +                * High
> +
> +        A Simple Signal is associated to a Simple Count.

Might be worth noting that there may be no visibility of this to software.

> +
> +        SYNAPSE
> +        -------
> +        A Synapse represents the association of a Signal with a
> +        respective Count. Signal data affects respective Count data, and
> +        the Synapse represents this relationship.
> +
> +        The Synapse action mode specifies the Signal data condition
> +        which triggers the respective Count's count function evaluation
> +        to update the count data. There are four possible action modes
> +        for a Simple Counter:
> +
> +                * None:
> +                        Signal does not trigger the count function.
> +                * Rising Edge:
> +                        Low state transitions to High state.
> +                * Falling Edge:
> +                        High state transitions to Low state.
> +                * Both Edges:
> +                        Any state transition.
> +
> +Paradigm
> +========
> +
> +Simple Counter devices consist of a single Count associated with a
> +single Signal via a single Synapse. Take for example a counter device
> +which simply accumulates a count of rising edges on a source input line.
> +
> +        Count                Synapse        Signal
> +        -----                -------        ------
> ++---------------------+
> +| Data: Count         |    Rising Edge     ________
> +| Function: Increase  |  <-------------   / Source \
> +|                     |                  ____________
> ++---------------------+
> +
> +In this example, the Signal is a source input line with a pulsing
> +voltage, while the Count is a persistent count value which is repeatedly
> +incremented. The Signal is associated with the respective Count via a
> +Synapse. The increase function is triggered by the Signal data condition
> +specified by the Synapse -- in this case a rising edge condition on the
> +voltage input line.
> +
> +In summary, the simple counter device existence and behavior is aptly
> +represented by respective Count, Signal, and Synapse components: e.g. a
> +rising edge condition triggers an increase function on an accumulating
> +count datum.
> +
> +Userspace Interface
> +===================
> +
> +Several sysfs attributes are generated by the Simple Counter interface,
> +and reside under the /sys/bus/counter/devices/counterX directory, where
> +counterX refers to the respective counter device. Please see
> +Documentation/ABI/testing/sys-bus-counter-simple-sysfs for detailed
> +information on each Simple Counter interface sysfs attribute.
> +
> +In addition, several sysfs attributes are generated by the underlying
> +Generic Counter interface, and also reside under the
> +/sys/bus/counter/devices/counterX directory, where counterX refers to
> +the respective counter device. Please see
> +Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
> +information on each Generic Counter interface sysfs attribute.
> +
> +Through these sysfs attributes, programs and scripts may interact with
> +the Simple Counter paradigm Counts, Signals, and Synapses of respective
> +counter devices.
> +
> +Driver API
> +==========
> +
> +Driver authors may utilize the Simple Counter interface in their code
> +by including the include/linux/iio/counter.h header file. 

I would have a separate header file for the simple counter that
itself includes counter.h.  Thus devices not using simple counter don't
get to see its functions etc.  You might not even build it for example.

> This header
> +file provides several core data structures and function prototypes for
> +defining a simple counter.
> +
> +
> +struct simple_counter_signal_ext
> +--------------------------------
> +
> +This structure defines a Simple Counter Signal extension attribute.
> +These attributes expose auxiliary configuration and functionality
> +specific to the respective Simple Counter Signal.
> +
> +        name:   attribute name
> +        read:   read callback for this attribute; may be NULL
> +        write:  write callback for this attribute; may be NULL
> +        priv:   data private to the driver
> +
> +struct simple_counter_signal
> +----------------------------
> +
> +This structure defines a Simple Counter Signal component. Typically,
> +this will correlate with an input channel on a physical counter device.
> +This structure is the simplest of the Simple Counter paradigm core
> +components to define with only two structure members which require
> +explicit configuration:
> +
> +        id:             unique ID used to identify signal
> +        name:           device-specific signal name
> +        ext:            optional array of Simple Counter Signal
> +                        extensions
> +        num_ext:        number of Simple Counter Signal extensions
> +                        specified in @ext
> +        priv:           optional private data supplied by driver
> +
> +enum simple_counter_signal_level
> +--------------------------------
> +
> +This enum defines enumeration constants to represent the possible Simple
> +Signal data level states.
> +
> +        SIMPLE_COUNTER_SIGNAL_LOW:      Low
> +        SIMPLE_COUNTER_SIGNAL_HIGH:     High
> +
> +enum simple_counter_function
> +----------------------------
> +
> +This enum defines enumeration constants to represent the possible Simple
> +Counter count function modes.
> +
> +        SIMPLE_COUNTER_FUNCTION_INCREASE:       Increase
> +        SIMPLE_COUNTER_FUNCTION_DECREASE:       Decrease
> +
> +enum simple_counter_action
> +--------------------------
> +
> +This enum defines enumeration constants to represent the possible Simple
> +Counter action modes.
> +
> +        SIMPLE_COUNTER_ACTION_NONE:             None
> +        SIMPLE_COUNTER_ACTION_RISING_EDGE:      Rising Edge
> +        SIMPLE_COUNTER_ACTION_FALLING_EDGE:     Falling Edge
> +        SIMPLE_COUNTER_ACTION_BOTH_EDGES:       Both Edges
> +
> +struct simple_counter_count_ext
> +-------------------------------
> +
> +This structure defines a Simple Counter Count extension attribute. These
> +attributes expose auxiliary configuration and functionality specific to
> +the respective Simple Counter Count.
> +
> +        name:   attribute name
> +        read:   read callback for this attribute; may be NULL
> +        write:  write callback for this attribute; may be NULL
> +        priv:   data private to the driver
> +
> +struct simple_counter_count
> +---------------------------
> +
> +This structure defines a Simple Counter Count component. Typically, this
> +will correlate with the read data (the "count" value) provided by a
> +physical counter device. This structure requires the explicit
> +configuration of an ID, name, and the Simple Signal associated with this
> +Simple Count.
> +
> +        id:             unique ID used to identify Count
> +        name:           device-specific Count name
> +        function:       current function mode
> +        action:         current action mode
> +        signal:         associated signal
> +        ext:            optional array of Simple Counter Count
> +                        extensions
> +        num_ext:        number of Simple Counter Count extensions
> +                        specified in @ext
> +        priv:           optional private data supplied by driver
> +
> +struct simple_counter_device_ext
> +--------------------------------
> +
> +This structure defines a Simple Counter extension attribute. These
> +attributes expose auxiliary configuration and functionality specific to
> +the respective Simple Counter.
> +
> +        name:   attribute name
> +        read:   read callback for this attribute; may be NULL
> +        write:  write callback for this attribute; may be NULL
> +        priv:   data private to the driver
> +
> +struct simple_counter_device
> +----------------------------
> +
> +This is the main data structure for a Simple Counter device. Access to
> +all respective Counts, Signals, and Synapses is possible from this
> +structure. This structure requires the configuration of a name and
> +Simple Counter Counts:
> +
> +        name:           name of the device
> +        parent:         optional parent device providing the counters
> +        signal_read:    read callback for Signal attribute; may be NULL.
> +                        Returns 0 on success and negative error code on
> +                        error. The respective Signal's returned level
> +                        should be passed back via the level parameter.
> +        signal_write:   write callback for Signal attribute; may be NULL
> +        count_read:     read callback for Count attribute; may be NULL.
> +                        Returns 0 on success and negative error code on
> +                        error. The respective Count's returned value
> +                        should be passed back via the val parameter.
> +        count_write:    write callback for Count attribute; may be NULL
> +        function_get:   function to get the current count function mode.
> +                        Returns 0 on success and negative error code on
> +                        error. The respective Count's returned function
> +                        mode should be passed back via the function
> +                        parameter.
> +        function_set:   function to set the count function mode
> +        action_get:     function to get the current action mode. Returns
> +                        0 on success and negative error code on error.
> +                        The respective Signal's returned action mode
> +                        should be passed back via the action parameter.
> +        action_set:     function to set the action mode
> +        counts:         array of Simple Counter Counts
> +        num_counts:     number of Simple Counter Counts specified in
> +                        @counts
> +        ext:            optional array of Simple Counter device
> +                        extensions
> +        num_ext:        number of Simple Counter device extensions
> +                        specified in @ext
> +        priv:           optional private data supplied by driver
> +
> +Registration functions
> +----------------------
> +
> +A simple counter device is registered to the system by passing the
> +respective initialized simple_counter_device structure to the
> +simple_counter_register function; similarly, the
> +simple_counter_unregister function unregisters the respective
> +Simple Counter. The devm_simple_counter_register and
> +devm_simple_counter_unregister functions serve as device memory-managed
> +versions of the simple_counter_register and simple_counter_unregister
> +functions respectively.
> +
> +Implementation
> +==============
> +
> +To use the Simple Counter interface, create an array of
> +simple_counter_count structures to represent the desired Counts and
> +Signals of the counter device. The simple_counter_count structure has a
> +Simple Signal member that represents the associated Signal, so only the
> +Simple Counts need to be explicited allocated -- the associated Simple
> +Signal members are simply populated with the respective desired
> +definitions. The defined simple_counter_count array may then be added
> +to a simple_counter_device structure for registration to the system.
> +
> +     Simple Count                    Count               Signal
> +     ------------                    -----               ------
> ++---------------------+      +--------------------+
> +| Data: Count         | ---> | Data: Count        |
> +| Function: Increase  |      | Function: Increase |
> +|                     |      +--------------------+
> +|                     |
> ++---------------------+                                 ________
> +| Signal: Source      | ---------------------------->  / Source \
> +|                     |                               ____________
> ++---------------------+
> +
> +Driver callbacks should be provided to the simple_counter_device
> +structure in order to communicate with the device: to read and write
> +various Signals and Counts, and to set and get the "action mode" and
> +"function mode" for various Synapses and Counts respectively.
> +
> +A defined simple_counter_device structure may be registered to the
> +system by passing it to the simple_counter_register function, and
> +unregistered by passing it to the simple_counter_unregister function.
> +Similarly, the devm_simple_counter_register and
> +devm_simple_counter_unregister functions may be used if device
> +memory-managed registration is desired.
> +
> +Extension sysfs attributes can be created for auxiliary functionality
> +and data by passing in defined simple_counter_device_ext,
> +simple_counter_count_ext, and simple_counter_signal_ext structures. In
> +these cases, the simple_counter_device_ext structure is used for global
> +configuration of the respective Counter device, while the
> +simple_counter_count_ext and simple_counter_signal_ext structures allow
> +for auxiliary exposure and configuration of a specific Count or Signal
> +respectively.
> +
> +Architecture
> +============
> +
> +The Simple Counter interface is a subclass of the Generic Counter
> +interface, and the Simple Counter interface functions serve as mappings
> +onto the Generic Counter interface functions to simplify and aptly
> +define support for simple counter devices.
> +
> +In this vein, the Generic Counter interface functions are ultimately
> +called when the Simple Counter interface functions are utilized. For
> +more information on the architecture of the Generic Counter interface,
> +please refer to the Documentation/driver-api/iio/generic-counter.rst
> +file.
> +
> +Simple Counter devices are registered to the system via the
> +simple_counter_register function, and later removed via the
> +simple_counter_unregister function. The simple_counter_register function
> +will allocate a counter_device structure, populate it with the required
> +Generic Counter structures and data required to represent the Simple
> +Counter components, and register it to the system via a counter_register
> +call.
> +
> +  _______________________       +-------------------------+
> + / simple_counter_device \  --> | simple_counter_register |
> +___________________________     +-------------------------+
> +                                  |
> +   +------------------------------+
> +   |
> +   V
> +  ________________       +------------------+
> + / counter_device \  --> | counter_register |
> +____________________     +------------------+
> +
> +The signal_read/signal_write driver callbacks, the
> +count_read/count_write and function_get/function_set driver callbacks,
> +and the action_get/action_set driver callbacks are mapped to the
> +allocated internal counter_device structure via appropriate hook
> +functions.
> +
> +        Simple Counter  Remap Function                  Generic Counter
> +        --------------  --------------                  ---------------
> +
> +        signal_read     simple_counter_signal_read      signal_read
> +        signal_write    simple_counter_signal_write     signal_write
> +        count_read      simple_counter_count_read       count_read
> +        count_write     simple_counter_count_write      count_write
> +        function_get    simple_counter_function_get     function_get
> +        function_set    simple_counter_function_set     function_set
> +        action_get      simple_counter_action_get       action_get
> +        action_set      simple_counter_action_set       action_set
> +
> +This is how Generic Counter interface sysfs attributes are inherited and
> +extended by the Simple Counter interface. If a driver callback is left
> +undefined, then the respective read/write permission is left disabled
> +for the relevant attributes.
> +
> +Similarly, simple_counter_device_ext, simple_counter_count_ext, and
> +simple_counter_signal_ext structures are mapped to respective
> +counter_device_ext, counter_count_ext, and counter_signal_ext structures
> +via appropriate hook functions, and then added to the allocated internal
> +counter_device structure for registration.

