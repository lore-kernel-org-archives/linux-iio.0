Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
Date: Tue, 24 Mar 2015 11:37:38 +0100
Message-ID: <CACRpkdaU955EvLT2dxTfYcof99BqbbxjHqhZh0tpQoYBq+ZjUQ@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Linus Walleij <linus.walleij@linaro.org>
To: Robert Dolca <robert.dolca@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 23, 2015 at 2:40 PM, Robert Dolca <robert.dolca@intel.com> wrote:

> Signed-off-by: Robert Dolca <robert.dolca@intel.com>

More comments...

> +static const char L3G4200D_gyro_dev_name[]  = "l3g4200d";
> +static const char LSM330D_gyro_dev_name[]   = "lsm330d_gyro";
> +static const char LSM330DL_gyro_dev_name[]  = "lsm330dl_gyro";
> +static const char LSM330DLC_gyro_dev_name[] = "lsm330dlc_gyro";
> +static const char L3GD20_gyro_dev_name[]    = "l3gd20";
> +static const char L3G4IS_gyro_dev_name[]    = "l3g4is_ui";
> +static const char LSM330_gyro_dev_name[]    = "lsm330_gyro";

Look here:
drivers/iio/gyro/st_gyro.h

#define L3G4200D_GYRO_DEV_NAME          "l3g4200d"
#define LSM330D_GYRO_DEV_NAME           "lsm330d_gyro"
#define LSM330DL_GYRO_DEV_NAME          "lsm330dl_gyro"
#define LSM330DLC_GYRO_DEV_NAME         "lsm330dlc_gyro"
#define L3GD20_GYRO_DEV_NAME            "l3gd20"
#define L3G4IS_GYRO_DEV_NAME            "l3g4is_ui"
#define LSM330_GYRO_DEV_NAME            "lsm330_gyro"

Don't redo these definitons, use the defines from the header file.
The DT table uses them.

Atleast do:
static const char L3G4200D_gyro_dev_name[]  = L3G4200D_GYRO_DEV_NAME;

Yours,
Linus Walleij
