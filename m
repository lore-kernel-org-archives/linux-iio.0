Return-Path: <vivien.didelot@savoirfairelinux.com>
Date: Thu, 9 Jan 2014 12:39:42 -0500 (EST)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, kernel@savoirfairelinux.com
Message-ID: <2013486580.319791.1389289182921.JavaMail.root@mail>
In-Reply-To: <235056967.112251.1389282903427.JavaMail.root@mail>
Subject: max1363: internal reference
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

As described in the max1363.c header, the control of the internal
reference is not currently supported by the driver.

We have two max11603 and max11605 which need this option. We currently
use a monkey patch like this in max1363.c:

    @@ -1414,7 +1414,12 @@ static const struct max1363_chip_info ma
     static int max1363_initial_setup(struct max1363_state *st)
     {
    +#ifdef OUR_BOARD
    +      st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_INT
    +#else
           st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
    +#endif
                   | MAX1363_SETUP_POWER_UP_INT_REF
                   | MAX1363_SETUP_INT_CLOCK
                   | MAX1363_SETUP_UNIPOLAR

In order to add the support for this, I would suggest adding a 
platform_data for this driver such as:

    struct max1363_platform_data {
        bool internal_reference;
    };

What do you think?

Best,
Vivien
