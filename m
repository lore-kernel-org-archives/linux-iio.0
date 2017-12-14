Return-Path: <SRS0=Dxs2=DK=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: benjamin.gaignard@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 10/11] docs: Add Quadrature Counter interface documentation
Date: Thu, 14 Dec 2017 15:52:56 -0500
Message-Id: <07b51f505f59ff24fa9234e550fa4d7f7cc5c01d.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds high-level documentation about the Quadrature Counter
interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/iio/index.rst        |   1 +
 Documentation/driver-api/iio/quad-counter.rst | 444 ++++++++++++++++++++++++++
 2 files changed, 445 insertions(+)
 create mode 100644 Documentation/driver-api/iio/quad-counter.rst

diff --git a/Documentation/driver-api/iio/index.rst b/Documentation/driver-api/iio/index.rst
index 60e17f16cfb8..db1e2d7e7b87 100644
--- a/Documentation/driver-api/iio/index.rst
+++ b/Documentation/driver-api/iio/index.rst
@@ -17,3 +17,4 @@ Contents:
    triggered-buffers
    generic-counter
    simple-counter
+   quad-counter
diff --git a/Documentation/driver-api/iio/quad-counter.rst b/Documentation/driver-api/iio/quad-counter.rst
new file mode 100644
index 000000000000..4800feafd6ba
--- /dev/null
+++ b/Documentation/driver-api/iio/quad-counter.rst
@@ -0,0 +1,444 @@
+============================
+Quadrature Counter Interface
+============================
+
+Introduction
+============
+
+A common use for counter devices is position tracking. There are several
+protocols for the communication of position changes, but one of the most
+popular is the quadrature encoding system utilized commonly by rotary
+encoder and linear encoder devices.
+
+A quadrature counter device is a counter device that tracks positions
+based on pairs of quadrature encoder inputs. A Quadrature Counter device
+may be expressed as consisting of single Counts each associated with a
+pair of Signals via respective Synapses.
+
+This driver API provides a basic Counter interface and standard of
+interaction and exposure for these quadrature counter devices. The
+Quadrature Counter interface enables drivers to support and expose
+quadrature counter devices in a more apt and well-defined way, without
+the hassles and imprecisions of utilizing a more generic interface.
+
+Theory
+======
+
+The Quadrature Counter interface may be considered a subclass of the
+Generic Counter interface; the same paradigm core components apply:
+Counts, Signals, and Synapses. However, the Quadrature Counter interface
+goes a bit further and defines aspects of those core components to
+properly represent Quadrature Counter devices.
+
+The three core components of a Quadrature Counter:
+
+        COUNT
+        -----
+        A Count represents the count data for a set of Signals. The
+        count data for a Quadrature Counter is a signed integer
+        representing the position.
+
+        A Count has a count function mode which represents the update
+        behavior for the count data. The following four count function
+        modes are possible for a Quadrature Count:
+
+                * Pulse-Direction:
+                        Rising edges on quadrature pair signal A updates
+                        the respective count. The input level of
+                        quadrature pair signal B determines direction.
+                * Quadrature x1:
+                        If direction is forward, rising edges on
+                        quadrature pair signal A updates the respective
+                        count; if the direction is backward, falling
+                        edges on quadrature pair signal A updates the
+                        respective count. Quadrature encoding determines
+                        the direction.
+                * Quadrature x2:
+                        Any state transition on quadrature pair signal A
+                        updates the respective count. Quadrature
+                        encoding determines the direction.
+                * Quadrature x4:
+                        Any state transition on either quadrature pair
+                        signals updates the respective count. Quadrature
+                        encoding determines the direction.
+
+        A Quadrature Count has a pair associated Quadrature Signals.
+
+        SIGNAL
+        ------
+        A Signal represents a counter input data; this is the data that
+        is typically analyzed by the counter to determine the count
+        data. A Quadrature Signal represents a quadrature counter input
+        line with two possible states:
+
+                * Low
+                * High
+
+        A Quadrature Signal is associated to a Quadrature Count.
+
+        SYNAPSE
+        -------
+        A Synapse represents the association of a Signal with a
+        respective Count. Signal data affects respective Count data, and
+        the Synapse represents this relationship.
+
+        The Synapse action mode specifies the Signal data condition
+        which triggers the respective Count's count function evaluation
+        to update the count data. There are four possible action modes
+        for a Quadrature Counter:
+
+                * None:
+                        Signal does not trigger the count function. In
+                        Pulse-Direction count function mode, this Signal
+                        is evaluated as Direction.
+                * Rising Edge:
+                        Low state transitions to High state.
+                * Falling Edge:
+                        High state transitions to Low state.
+                * Both Edges:
+                        Any state transition.
+
+Paradigm
+========
+
+Quadrature Counter devices consist of a single Count associated with a
+pair of Signals via respective Synapses. Take for example a quadrature
+counter device which tracks position via the evaluation of a pair of
+quadrature encoder lines.
+
+           Count                 Synapse     Signal
+           -----                 -------     ------
++-------------------------+
+| Data: Position          |    Both Edges     ___
+| Function: Quadrature x4 |  <------------   / A \
+|                         |                 _______
+|                         |
+|                         |    Both Edges     ___
+|                         |  <------------   / B \
+|                         |                 _______
++-------------------------+
+
+In this example, two Signals (quadrature encoder lines A and B) are
+associated to a single Count: a rising or falling edge on either A or B
+triggers the "Quadrature x4" function which determines the direction of
+movement and updates the respective position data. The "Quadrature x4"
+function is likely implemented in the hardware of the quadrature encoder
+counter device; the Count, Signals, and Synapses simply represent this
+hardware behavior and functionality.
+
+In addition, a quadrature encoder counter device operating in a
+non-quadrature Pulse-Direction mode could have one input line dedicated
+for movement and a second input line dedicated for direction.
+
+           Count                   Synapse      Signal
+           -----                   -------      ------
++---------------------------+
+| Data: Position            |    Rising Edge     ___
+| Function: Pulse-Direction |  <-------------   / A \ (Movement)
+|                           |                  _______
+|                           |
+|                           |       None         ___
+|                           |  <-------------   / B \ (Direction)
+|                           |                  _______
++---------------------------+
+
+Only Signal A triggers the "Pulse-Direction" update function, but the
+instantaneous state of Signal B is still required in order to know the
+direction so that the position data may be properly updated. Ultimately,
+both Signals are associated to the same Count via two respective
+Synapses, but only one Synapse has an active action mode condition which
+triggers the respective count function while the other is left with a
+"None" condition action mode to indicate its respective Signal's
+availability for state evaluation despite its non-triggering mode.
+
+Userspace Interface
+===================
+
+Several sysfs attributes are generated by the Quadrature Counter
+interface, and reside under the /sys/bus/counter/devices/counterX
+directory, where counterX refers to the respective counter device.
+Please see Documentation/ABI/testing/sys-bus-counter-quadrature-sysfs
+for detailed information on each Quadrature Counter interface sysfs
+attribute.
+
+In addition, several sysfs attributes are generated by the underlying
+Generic Counter interface, and also reside under the
+/sys/bus/counter/devices/counterX directory, where counterX refers to
+the respective counter device. Please see
+Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
+information on each Generic Counter interface sysfs attribute.
+
+Through these sysfs attributes, programs and scripts may interact with
+the Quadrature Counter paradigm Counts, Signals, and Synapses of
+respective counter devices.
+
+Driver API
+==========
+
+Driver authors may utilize the Quadrature Counter interface in their
+code by including the include/linux/iio/counter.h header file. This
+header file provides several core data structures and function
+prototypes for defining a quadrature counter.
+
+
+struct quad_counter_signal_ext
+------------------------------
+
+This structure defines a Quadrature Counter Signal extension attribute.
+These attributes expose auxiliary configuration and functionality
+specific to the respective Quadrature Counter Signal.
+
+        name:   attribute name
+        read:   read callback for this attribute; may be NULL
+        write:  write callback for this attribute; may be NULL
+        priv:   data private to the driver
+
+struct quad_counter_signal
+--------------------------
+
+This structure defines a Quadrature Counter Signal component. Typically,
+this will correlate with a quadrature encoding line input channel on a
+physical counter device. This structure is the simplest of the
+Quadrature Counter paradigm core components to define with only two
+structure members which require explicit configuration:
+
+        id:             unique ID used to identify signal
+        name:           device-specific signal name
+        ext:            optional array of Quadrature Counter Signal
+                        extensions
+        num_ext:        number of Quadrature Counter Signal extensions
+                        specified in @ext
+        priv:           optional private data supplied by driver
+
+enum quad_counter_signal_level
+------------------------------
+
+This enum defines enumeration constants to represent the possible
+Quadrature Signal data level states.
+
+        QUAD_COUNTER_SIGNAL_LOW:      Low
+        QUAD_COUNTER_SIGNAL_HIGH:     High
+
+enum quad_counter_function
+--------------------------
+
+This enum defines enumeration constants to represent the possible
+Quadrature Counter count function modes.
+
+        QUAD_COUNTER_FUNCTION_PULSE_DIRECTION:  Pulse-Direction
+        QUAD_COUNTER_FUNCTION_QUADRATURE_X1:    Quadrature x1
+        QUAD_COUNTER_FUNCTION_QUADRATURE_X2:    Quadrature x2
+        QUAD_COUNTER_FUNCTION_QUADRATURE_X4:    Quadrature x4
+
+enum quad_counter_direction
+--------------------------
+
+This enum defines enumeration constants to represent the possible
+Quadrature Counter directions.
+
+        QUAD_COUNTER_DIRECTION_FORWARD:         Forward
+        QUAD_COUNTER_DIRECTION_BACKWARD:        Backward
+
+struct quad_counter_count_ext
+-------------------------------
+
+This structure defines a Quadrature Counter Count extension attribute.
+These attributes expose auxiliary configuration and functionality
+specific to the respective Quadrature Counter Count.
+
+        name:   attribute name
+        read:   read callback for this attribute; may be NULL
+        write:  write callback for this attribute; may be NULL
+        priv:   data private to the driver
+
+struct quad_counter_count
+-------------------------
+
+This structure defines a Quadrature Counter Count component. Typically,
+this will correlate with the read data (the "position" value) provided
+by a physical counter device. This structure requires the explicit
+configuration of an ID, name, and the pair of Quadrature Signals
+associated with this Quadrature Count.
+
+        id:             unique ID used to identify Count
+        name:           device-specific Count name
+        function:       current function mode
+        direction:      current direction state
+        signal_a:       associated quadrature A signal
+        signal_b:       associated quadrature B signal
+        ext:            optional array of Quadrature Counter Count
+                        extensions
+        num_ext:        number of Quadrature Counter Count extensions
+                        specified in @ext
+        priv:           optional private data supplied by driver
+
+struct quad_counter_device_ext
+------------------------------
+
+This structure defines a Quadrature Counter extension attribute. These
+attributes expose auxiliary configuration and functionality specific to
+the respective Quadrature Counter.
+
+        name:   attribute name
+        read:   read callback for this attribute; may be NULL
+        write:  write callback for this attribute; may be NULL
+        priv:   data private to the driver
+
+struct quad_counter_device
+--------------------------
+
+This is the main data structure for a Quadrature Counter device. Access
+to all respective Counts, Signals, and Synapses is possible from this
+structure. This structure requires the configuration of a name and
+Quadrature Counter Counts:
+
+        name:           name of the device
+        parent:         optional parent device providing the counters
+        signal_read:    read callback for Signal attribute; may be NULL.
+                        Returns 0 on success and negative error code on
+                        error. The respective Signal's returned level
+                        should be passed back via the level parameter.
+        count_read:     read callback for Count attribute; may be NULL.
+                        Returns 0 on success and negative error code on
+                        error. The respective Count's returned value
+                        should be passed back via the val parameter.
+        count_write:    write callback for Count attribute; may be NULL
+        function_get:   function to get the current count function mode.
+                        Returns 0 on success and negative error code on
+                        error. The respective Count's returned function
+                        mode should be passed back via the function
+                        parameter.
+        function_set:   function to set the count function mode
+        direction_get:  function to get the current direction. Returns 0
+                        on success and negative error code on error. The
+                        respective Count's returned direction should be
+                        passed back via the direction parameter.
+        counts:         array of Quadrature Counter Counts
+        num_counts:     number of Quadrature Counter Counts specified in
+                        @counts
+        ext:            optional array of Quadrature Counter device
+                        extensions
+        num_ext:        number of Quadrature Counter device extensions
+                        specified in @ext
+        priv:           optional private data supplied by driver
+
+Registration functions
+----------------------
+
+A quadrature counter device is registered to the system by passing the
+respective initialized quad_counter_device structure to the
+quad_counter_register function; similarly, the quad_counter_unregister
+function unregisters the respective Quadrature Counter. The
+devm_quad_counter_register and devm_quad_counter_unregister functions
+serve as device memory-managed versions of the quad_counter_register and
+quad_counter_unregister functions respectively.
+
+Implementation
+==============
+
+To use the Quadrature Counter interface, create an array of
+quad_counter_count structures to represent the desired Counts and
+Signals of the quadrature counter device; the signal_a member of a
+quad_counter_count structure should define the Channel A signal of the
+respective quadrature encoding pair, and similarly the signal_b member
+should define Channel B. The defined quad_counter_count array may then
+be added to a quad_counter_device structure for registration to the
+system.
+
+      Quad Count                          Count              Signal
+      ----------                          -----              ------
++-------------------------+    +-------------------------+
+| Data: Position          | -> | Data: Position          |
+| Function: Quadrature x4 |    | Function: Quadrature x4 |
+|                         |    +-------------------------+
+|                         |
++-------------------------+                                 ________
+| Signal: Quad A          | ---------------------------->  / Quad A \
+|                         |                               ____________
+|                         |
++-------------------------+                                 ________
+| Signal: Quad B          | ---------------------------->  / Quad B \
+|                         |                               ____________
++-------------------------+
+
+Driver callbacks should be provided to the quad_counter_device structure
+in order to communicate with the device: to read and write various
+Counts, to read various Signals, to get and set the "function mode" for
+various Counts, and to get the direction for various Counts.
+
+A defined quad_counter_device structure may be registered to the system
+by passing it to the quad_counter_register function, and unregistered by
+passing it to the quad_counter_unregister function. Similarly, the
+devm_quad_counter_register and devm_quad_counter_unregister functions
+may be used if device memory-managed registration is desired.
+
+Extension sysfs attributes can be created for auxiliary functionality
+and data by passing in defined quad_counter_device_ext,
+quad_counter_count_ext, and quad_counter_signal_ext structures. In
+these cases, the quad_counter_device_ext structure is used for global
+configuration of the respective Counter device, while the
+quad_counter_count_ext and quad_counter_signal_ext structures allow
+for auxiliary exposure and configuration of a specific Count or Signal
+respectively.
+
+Architecture
+============
+
+The Quadrature Counter interface is a subclass of the Generic Counter
+interface, and the Quadrature Counter interface functions serve as
+mappings onto the Generic Counter interface functions to simplify and
+aptly define support for quadrature counter devices.
+
+In this vein, the Generic Counter interface functions are ultimately
+called when the Quadrature Counter interface functions are utilized. For
+more information on the architecture of the Generic Counter interface,
+please refer to the Documentation/driver-api/iio/generic-counter.rst
+file.
+
+Quadrature Counter devices are registered to the system via the
+quad_counter_register function, and later removed via the
+quad_counter_unregister function. The quad_counter_register function
+will allocate a counter_device structure, populate it with the required
+Generic Counter structures and data required to represent the Quadrature
+Counter components, and register it to the system via a counter_register
+call.
+
+  _____________________       +-----------------------+
+ / quad_counter_device \  --> | quad_counter_register |
+_________________________     +-----------------------+
+                                  |
+   +------------------------------+
+   |
+   V
+  ________________       +------------------+
+ / counter_device \  --> | counter_register |
+____________________     +------------------+
+
+The signal_read driver callback, the count_read/count_write and
+function_get/function_set driver callbacks, and the direction_get driver
+callbacks are mapped to the allocated internal counter_device structure
+via appropriate hook functions.
+
+        Quad Counter    Remap Function                  Generic Counter
+        ------------    --------------                  ---------------
+
+        signal_read     quad_counter_signal_read        signal_read
+        count_read      quad_counter_count_read         count_read
+        count_write     quad_counter_count_write        count_write
+        function_get    quad_counter_function_get       function_get
+        function_set    quad_counter_function_set       function_set
+        direction_get   quad_counter_action_get         action_get
+
+This is how Generic Counter interface sysfs attributes are inherited and
+extended by the Quadrature Counter interface. If a driver callback is
+left undefined, then the respective read/write permission is left
+disabled for the relevant attributes. The quad_counter_action_get
+function in particular depends on both direction_get and function_get --
+so if either driver callback is undefined, the internal counter_device
+action_get function pointer is left as NULL.
+
+Similarly, quad_counter_device_ext, quad_counter_count_ext, and
+quad_counter_signal_ext structures are mapped to respective
+counter_device_ext, counter_count_ext, and counter_signal_ext structures
+via appropriate hook functions, and then added to the allocated internal
+counter_device structure for registration.
-- 
2.15.1
