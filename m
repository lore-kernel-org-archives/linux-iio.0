Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57880 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbcGSFgY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:24 -0400
Subject: Re: [PATCH 02/10] mfd: cros_ec: update MOTIONSENSE definitions and
 commands.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
 <1468825370-20075-3-git-send-email-enric.balletbo@collabora.com>
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <efb67c38-f5d5-a3b3-a3fd-1caf13fb9302@kernel.org>
Date: Mon, 18 Jul 2016 14:49:45 +0100
MIME-Version: 1.0
In-Reply-To: <1468825370-20075-3-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 08:02, Enric Balletbo i Serra wrote:
> Let's update the command header to include the definitions related to
> the sensors attached behind the ChromeOS Embedded Controller. The new
> commands and definitions allow us to get information from these sensors.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Again, I'd be happier seeing this stuff introduced as and when it
is needed rather than in a magic patch. It's hard to review stuff
if it's broken up across multiple patches like this.

A few other bits and pieces inline.

Jonathan
> ---
>  include/linux/mfd/cros_ec_commands.h | 260 +++++++++++++++++++++++++++++++----
>  1 file changed, 231 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 76728ff..f26a806 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1290,7 +1290,13 @@ enum motionsense_command {
>  
>  	/*
>  	 * EC Rate command is a setter/getter command for the EC sampling rate
> -	 * of all motion sensors in milliseconds.
> +	 * in milliseconds.
> +	 * It is per sensor, the EC run sample task  at the minimum of all
> +	 * sensors EC_RATE.
> +	 * For sensors without hardware FIFO, EC_RATE should be equals to 1/ODR
> +	 * to collect all the sensor samples.
> +	 * For sensor with hardware FIFO, EC_RATE is used as the maximal delay
> +	 * to process of all motion sensors in milliseconds.
>  	 */
>  	MOTIONSENSE_CMD_EC_RATE = 2,
>  
> @@ -1315,37 +1321,138 @@ enum motionsense_command {
>  	 */
>  	MOTIONSENSE_CMD_KB_WAKE_ANGLE = 5,
>  
> -	/* Number of motionsense sub-commands. */
> -	MOTIONSENSE_NUM_CMDS
> -};
> +	/*
> +	 * Returns a single sensor data.
> +	 */
Please use standard kernel documentation formats throughout.
If not you may face a Linus rant ;)
> +	MOTIONSENSE_CMD_DATA = 6,
> +
> +	/*
> +	 * Return sensor fifo info.
> +	 */
> +	MOTIONSENSE_CMD_FIFO_INFO = 7,
> +
> +	/*
> +	 * Insert a flush element in the fifo and return sensor fifo info.
> +	 * The host can use that element to synchronize its operation.
> +	 */
> +	MOTIONSENSE_CMD_FIFO_FLUSH = 8,
>  
> -enum motionsensor_id {
> -	EC_MOTION_SENSOR_ACCEL_BASE = 0,
> -	EC_MOTION_SENSOR_ACCEL_LID = 1,
> -	EC_MOTION_SENSOR_GYRO = 2,
> +	/*
> +	 * Return a portion of the fifo.
> +	 */
> +	MOTIONSENSE_CMD_FIFO_READ = 9,
> +
> +	/*
> +	 * Perform low level calibration.
> +	 * On sensors that support it, ask to do offset calibration.
> +	 */
> +	MOTIONSENSE_CMD_PERFORM_CALIB = 10,
> +
> +	/*
> +	 * Sensor Offset command is a setter/getter command for the offset
> +	 * used for calibration.
> +	 * The offsets can be calculated by the host, or via
> +	 * PERFORM_CALIB command.
> +	 */
> +	MOTIONSENSE_CMD_SENSOR_OFFSET = 11,
> +
> +	/*
> +	 * List available activities for a MOTION sensor.
> +	 * Indicates if they are enabled or disabled.
> +	 */
> +	MOTIONSENSE_CMD_LIST_ACTIVITIES = 12,
>  
>  	/*
> -	 * Note, if more sensors are added and this count changes, the padding
> -	 * in ec_response_motion_sense dump command must be modified.
> +	 * Activity management
> +	 * Enable/Disable activity recognition.
>  	 */
> -	EC_MOTION_SENSOR_COUNT = 3
> +	MOTIONSENSE_CMD_SET_ACTIVITY = 13,
> +
> +	/* Number of motionsense sub-commands. */
> +	MOTIONSENSE_NUM_CMDS
>  };
>  
>  /* List of motion sensor types. */
>  enum motionsensor_type {
>  	MOTIONSENSE_TYPE_ACCEL = 0,
>  	MOTIONSENSE_TYPE_GYRO = 1,
> +	MOTIONSENSE_TYPE_MAG = 2,
> +	MOTIONSENSE_TYPE_PROX = 3,
> +	MOTIONSENSE_TYPE_LIGHT = 4,
> +	MOTIONSENSE_TYPE_ACTIVITY = 5,
> +	MOTIONSENSE_TYPE_MAX,
>  };
>  
>  /* List of motion sensor locations. */
>  enum motionsensor_location {
>  	MOTIONSENSE_LOC_BASE = 0,
>  	MOTIONSENSE_LOC_LID = 1,
> +	MOTIONSENSE_LOC_MAX,
>  };
>  
>  /* List of motion sensor chips. */
>  enum motionsensor_chip {
>  	MOTIONSENSE_CHIP_KXCJ9 = 0,
> +	MOTIONSENSE_CHIP_LSM6DS0 = 1,
> +	MOTIONSENSE_CHIP_BMI160 = 2,
> +	MOTIONSENSE_CHIP_SI1141 = 3,
> +	MOTIONSENSE_CHIP_SI1142 = 4,
> +	MOTIONSENSE_CHIP_SI1143 = 5,
> +	MOTIONSENSE_CHIP_KX022 = 6,
> +	MOTIONSENSE_CHIP_L3GD20H = 7,
Interesting.  So the driver needs some knowledge of what
is behind it.  I'll read on with interest ;)
> +};
> +
> +struct ec_response_motion_sensor_data {
> +	/* Flags for each sensor. */
> +	uint8_t flags;
> +	/* sensor number the data comes from */
> +	uint8_t sensor_num;
> +	/* Each sensor is up to 3-axis. */
> +	union {
> +		int16_t             data[3];
> +		struct {
> +			uint16_t    rsvd;
> +			uint32_t    timestamp;
> +		} __packed;
> +		struct {
> +			uint8_t     activity; /* motionsensor_activity */
> +			uint8_t     state;
> +			int16_t     add_info[2];
> +		};
> +	};
> +} __packed;
> +
> +struct ec_response_motion_sense_fifo_info {
> +	/* Size of the fifo */
> +	uint16_t size;
> +	/* Amount of space used in the fifo */
> +	uint16_t count;
> +	/* TImestamp recorded in us */
Timestamp
> +	uint32_t timestamp;
> +	/* Total amount of vector lost */
> +	uint16_t total_lost;
> +	/* Lost events since the last fifo_info, per sensors */
> +	uint16_t lost[0];
> +} __packed;
> +
> +struct ec_response_motion_sense_fifo_data {
> +	uint32_t number_data;
> +	struct ec_response_motion_sensor_data data[0];
> +} __packed;
> +
> +/* List supported activity recognition */
> +enum motionsensor_activity {
> +	MOTIONSENSE_ACTIVITY_RESERVED = 0,
> +	MOTIONSENSE_ACTIVITY_SIG_MOTION = 1,
> +	MOTIONSENSE_ACTIVITY_DOUBLE_TAP = 2,
> +};
> +
> +struct ec_motion_sense_activity {
> +	uint8_t sensor_num;
> +	uint8_t activity; /* one of enum motionsensor_activity */
> +	uint8_t enable;   /* 1: enable, 0: disable */
> +	uint8_t reserved;
> +	uint16_t parameters[3]; /* activity dependent parameters */
>  };
>  
>  /* Module flag masks used for the dump sub-command. */
> @@ -1355,41 +1462,61 @@ enum motionsensor_chip {
>  #define MOTIONSENSE_SENSOR_FLAG_PRESENT (1<<0)
>  
>  /*
> + * Flush entry for synchronisation.
> + * data contains time stamp
> + */
> +#define MOTIONSENSE_SENSOR_FLAG_FLUSH (1<<0)
> +#define MOTIONSENSE_SENSOR_FLAG_TIMESTAMP (1<<1)
> +#define MOTIONSENSE_SENSOR_FLAG_WAKEUP (1<<2)
> +
> +/*
>   * Send this value for the data element to only perform a read. If you
>   * send any other value, the EC will interpret it as data to set and will
>   * return the actual value set.
>   */
>  #define EC_MOTION_SENSE_NO_VALUE -1
>  
> +#define EC_MOTION_SENSE_INVALID_CALIB_TEMP 0x8000
> +
> +/* MOTIONSENSE_CMD_SENSOR_OFFSET subcommand flag */
> +/* Set Calibration information */
> +#define MOTION_SENSE_SET_OFFSET 1
> +
>  struct ec_params_motion_sense {
>  	uint8_t cmd;
>  	union {
> -		/* Used for MOTIONSENSE_CMD_DUMP. */
> +		/* Used for MOTIONSENSE_CMD_DUMP */
>  		struct {
> -			/* no args */
> +			/*
> +			 * Maximal number of sensor the host is expecting.
> +			 * 0 means the host is only interested in the number
> +			 * of sensors controlled by the EC.
> +			 */
> +			uint8_t max_sensor_count;
>  		} dump;
>  
>  		/*
> -		 * Used for MOTIONSENSE_CMD_EC_RATE and
> -		 * MOTIONSENSE_CMD_KB_WAKE_ANGLE.
> +		 * Used for MOTIONSENSE_CMD_KB_WAKE_ANGLE.
>  		 */
>  		struct {
> -			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
> +			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read.
> +			 * kb_wake_angle: angle to wakup AP.
> +			 */
>  			int16_t data;
> -		} ec_rate, kb_wake_angle;
> +		} kb_wake_angle;
>  
> -		/* Used for MOTIONSENSE_CMD_INFO. */
> +		/* Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
> +		 * and MOTIONSENSE_CMD_PERFORM_CALIB.
> +		 */
>  		struct {
> -			/* Should be element of enum motionsensor_id. */
>  			uint8_t sensor_num;
> -		} info;
> +		} info, data, fifo_flush, perform_calib, list_activities;
>  
>  		/*
> -		 * Used for MOTIONSENSE_CMD_SENSOR_ODR and
> -		 * MOTIONSENSE_CMD_SENSOR_RANGE.
> +		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
> +		 * and MOTIONSENSE_CMD_SENSOR_RANGE.
>  		 */
>  		struct {
> -			/* Should be element of enum motionsensor_id. */
>  			uint8_t sensor_num;
>  
>  			/* Rounding flag, true for round-up, false for down. */
> @@ -1399,22 +1526,69 @@ struct ec_params_motion_sense {
>  
>  			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
>  			int32_t data;
> -		} sensor_odr, sensor_range;
> +		} ec_rate, sensor_odr, sensor_range;
> +
> +		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
> +		struct {
> +			uint8_t sensor_num;
> +
> +			/*
> +			 * bit 0: If set (MOTION_SENSE_SET_OFFSET), set
> +			 * the calibration information in the EC.
> +			 * If unset, just retrieve calibration information.
> +			 */
> +			uint16_t flags;
> +
> +			/*
> +			 * Temperature at calibration, in units of 0.01 C
> +			 * 0x8000: invalid / unknown.
> +			 * 0x0: 0C
> +			 * 0x7fff: +327.67C
> +			 */
> +			int16_t temp;
> +
> +			/*
> +			 * Offset for calibration.
> +			 * Unit:
> +			 * Accelerometer: 1/1024 g
> +			 * Gyro:          1/1024 deg/s
> +			 * Compass:       1/16 uT
> +			 */
> +			int16_t offset[3];
> +		} __packed sensor_offset;
> +
> +		/* Used for MOTIONSENSE_CMD_FIFO_INFO */
> +		struct {
> +		} fifo_info;
> +
> +		/* Used for MOTIONSENSE_CMD_FIFO_READ */
> +		struct {
> +			/*
> +			 * Number of expected vector to return.
> +			 * EC may return less or 0 if none available.
> +			 */
> +			uint32_t max_data_vector;
> +		} fifo_read;
> +
> +		struct ec_motion_sense_activity set_activity;
>  	};
>  } __packed;
>  
>  struct ec_response_motion_sense {
>  	union {
> -		/* Used for MOTIONSENSE_CMD_DUMP. */
> +		/* Used for MOTIONSENSE_CMD_DUMP */
>  		struct {
>  			/* Flags representing the motion sensor module. */
>  			uint8_t module_flags;
>  
> -			/* Flags for each sensor in enum motionsensor_id. */
> -			uint8_t sensor_flags[EC_MOTION_SENSOR_COUNT];
> +			/* Number of sensors managed directly by the EC */
> +			uint8_t sensor_count;
>  
> -			/* Array of all sensor data. Each sensor is 3-axis. */
> -			int16_t data[3*EC_MOTION_SENSOR_COUNT];
> +			/*
> +			 * sensor data is truncated if response_max is too small
> +			 * for holding all the data.
> +			 */
> +			struct ec_response_motion_sensor_data sensor[0];
>  		} dump;
>  
>  		/* Used for MOTIONSENSE_CMD_INFO. */
> @@ -1429,6 +1603,9 @@ struct ec_response_motion_sense {
>  			uint8_t chip;
>  		} info;
>  
> +		/* Used for MOTIONSENSE_CMD_DATA */
> +		struct ec_response_motion_sensor_data data;
> +
>  		/*
>  		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR,
>  		 * MOTIONSENSE_CMD_SENSOR_RANGE, and
> @@ -1438,6 +1615,25 @@ struct ec_response_motion_sense {
>  			/* Current value of the parameter queried. */
>  			int32_t ret;
>  		} ec_rate, sensor_odr, sensor_range, kb_wake_angle;
> +
> +		/* Used for MOTIONSENSE_CMD_SENSOR_OFFSET */
> +		struct {
> +			int16_t temp;
> +			int16_t offset[3];
> +		} sensor_offset, perform_calib;
> +
> +		struct ec_response_motion_sense_fifo_info fifo_info, fifo_flush;
> +
> +		struct ec_response_motion_sense_fifo_data fifo_read;
> +
> +		struct {
> +			uint16_t reserved;
> +			uint32_t enabled;
> +			uint32_t disabled;
> +		} __packed list_activities;
> +
> +		struct {
> +		} set_activity;
>  	};
>  } __packed;
>  
> @@ -1819,6 +2015,12 @@ union ec_response_get_next_data {
>  
>  	/* Unaligned */
>  	uint32_t  host_event;
> +
> +	struct {
> +		/* For aligning the fifo_info */
> +		uint8_t rsvd[3];
> +		struct ec_response_motion_sense_fifo_info info;
> +	}        sensor_fifo;
>  } __packed;
>  
>  struct ec_response_get_next_event {
> 

