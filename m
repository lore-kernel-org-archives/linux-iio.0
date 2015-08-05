Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39486 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbbHEUPe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 16:15:34 -0400
In-Reply-To: <1438766895-15824-1-git-send-email-linus.walleij@linaro.org>
References: <1438766895-15824-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: st_common: use standard trigger suffix
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 05 Aug 2015 21:15:08 +0100
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Denis Ciocca <denis.ciocca@st.com>
Message-ID: <9F97DF0A-7CD3-4A1B-8B41-9B060A080F47@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 5 August 2015 10:28:15 BST, Linus Walleij <linus.walleij@linaro.org> wrote:
>The triggers from ST sensors are named <iio_device_name>-trigger
>instead of the standard <iio_device_name>-dev<iio_dev_id> as
>used by most and also in the iio-tools. Change this to match
>the norm.
>
>After this I can do tests with generic_buffer -n <dev_name>
>without having to manually specify the trigger with the -t
>option.
Hmm ABI change... Not a requirement that this naming be followed...

Could register the trigger twice I suppose so as to keep old name available.... 


>
>Cc: Denis Ciocca <denis.ciocca@st.com>
>Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>---
> drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c
>b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>index 3e907040c2c7..3c0aa17d753f 100644
>--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
>+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>@@ -24,7 +24,8 @@ int st_sensors_allocate_trigger(struct iio_dev
>*indio_dev,
> 	int err;
> 	struct st_sensor_data *sdata = iio_priv(indio_dev);
> 
>-	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
>+	sdata->trig = iio_trigger_alloc("%s-dev%d",
>+					indio_dev->name, indio_dev->id);
> 	if (sdata->trig == NULL) {
> 		err = -ENOMEM;
> 		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
