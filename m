Return-Path: <jic23@kernel.org>
In-Reply-To: <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org> <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 27/38] iio: pressure-core: st: Give some indication if device probing was successful
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 10 Sep 2013 17:25:37 +0100
To: Lee Jones <lee.jones@linaro.org>,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,jic23@cam.ac.uk
CC: arnd@arndb.de,linus.walleij@linaro.org,denis.ciocca@st.com,linux-iio@vger.kernel.org
Message-ID: <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Lee Jones <lee.jones@linaro.org> wrote:
>At the moment the driver is silent in some error cases and if
>successful.
>Prior to this patch there was no clear way to know if the driver
>succeeded
>or not without looking deep into sysfs.
>
>Signed-off-by: Lee Jones <lee.jones@linaro.org>
>---
> drivers/iio/pressure/st_pressure_core.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/iio/pressure/st_pressure_core.c
>b/drivers/iio/pressure/st_pressure_core.c
>index 6ffd949..34b3fb1 100644
>--- a/drivers/iio/pressure/st_pressure_core.c
>+++ b/drivers/iio/pressure/st_pressure_core.c
>@@ -280,6 +280,9 @@ int st_press_common_probe(struct iio_dev
>*indio_dev,
> 	if (err && irq > 0)
> 		goto st_press_device_register_error;
> 
>+	if (!err)
>+		dev_info(&indio_dev->dev, "Successfully registered\n");
>+
Not keen. That to my mind is pointless noise. If this made sense then it would be in the driver core not here.
> 	return err;
> 
> st_press_device_register_error:

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
