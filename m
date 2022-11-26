Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1337C4332F
	for <linux-iio@archiver.kernel.org>; Sat, 26 Nov 2022 18:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKZSv5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Nov 2022 13:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZSv4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2022 13:51:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE2D1179
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 10:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6425B80958
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 18:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506BC433D7;
        Sat, 26 Nov 2022 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669488712;
        bh=MQaeghK4uocu4KLwwzvj88gHV/ITTuW0M+Swg0js7NA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=athCk7qn4g7N+iBCXDC85SXHTlNNmy62sTpQ/lAzqHa0GLw64Y5k+D2DmMUWa/v4s
         S8Dk8bKuHFkvolZx/6Qz8IRXKQv4xS5b4hcj4dDa4VRLIwRUD+NzmdUFU6xUNE5U01
         HTWNWdn6/jhrI32pzPWRfyQsT6yBBNasuh7TWbubpTVwSN+TbJfqSMYa5VxcLdF6K6
         fODPqi8HtvIZESSGvyfjEoIww00aLVGQpOBVddCC54ctBSpOpzQuu+vRSWEYVgiIdo
         Op2kuZyZQcBdfjEvT1jYbolGxOjv1ZP6pFex+TNzMRRWOGwImj1rjzobpR+NTYTDNj
         vfEBqE88dP7PA==
Date:   Sat, 26 Nov 2022 19:04:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/4] IIO: hid-sensor-prox: Use generic usage
Message-ID: <20221126190429.1ca14050@jic23-huawei>
In-Reply-To: <20221124233841.3103-5-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
        <20221124233841.3103-5-p.jungkamp@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Nov 2022 00:38:41 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_PROX to
> allow this driver to drive the Lenvo custom proximity sensor, which is
> registered under a 'custom' usage and not HID_USAGE_SENSOR_PROX.
> 
> Add the Lenovo Intelligent Sensing Solution (LISS) human presence sensor
> to the platform device ids.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>

I gave a tag for this - if you deliberately didn't add it, I'd expect to see
a reason why.

Ah well, here it is again.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v2:
> - Remove some unnecessary newlines in function calls.
> 
> v3:
> - No change.
> 
> v4:
> - Clean up switch statement.
> 
>  drivers/iio/light/hid-sensor-prox.c | 37 ++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index f10fa2abfe72..a47591e1bad9 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -61,6 +61,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			      long mask)
>  {
>  	struct prox_state *prox_state = iio_priv(indio_dev);
> +	struct hid_sensor_hub_device *hsdev;
>  	int report_id = -1;
>  	u32 address;
>  	int ret_type;
> @@ -75,6 +76,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			report_id = prox_state->prox_attr.report_id;
>  			min = prox_state->prox_attr.logical_minimum;
>  			address = HID_USAGE_SENSOR_HUMAN_PRESENCE;
> +			hsdev = prox_state->common_attributes.hsdev;
>  			break;
>  		default:
>  			report_id = -1;
> @@ -84,11 +86,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  			hid_sensor_power_state(&prox_state->common_attributes,
>  						true);
>  			*val = sensor_hub_input_attr_get_raw_value(
> -				prox_state->common_attributes.hsdev,
> -				HID_USAGE_SENSOR_PROX, address,
> -				report_id,
> -				SENSOR_HUB_SYNC,
> -				min < 0);
> +				hsdev, hsdev->usage, address, report_id,
> +				SENSOR_HUB_SYNC, min < 0);
>  			hid_sensor_power_state(&prox_state->common_attributes,
>  						false);
>  		} else {
> @@ -191,10 +190,16 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
> 
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_HUMAN_PRESENCE:
> -		prox_state->human_presence = *(u32 *)raw_data;
> -		ret = 0;
> -		break;
> -	default:
> +		switch (raw_len) {
> +		case 1:
> +			prox_state->human_presence = *(u8 *)raw_data;
> +			return 0;
> +		case 4:
> +			prox_state->human_presence = *(u32 *)raw_data;
> +			return 0;
> +		default:
> +			break;
> +		}
>  		break;
>  	}
> 
> @@ -244,7 +249,7 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	prox_state->common_attributes.hsdev = hsdev;
>  	prox_state->common_attributes.pdev = pdev;
> 
> -	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_PROX,
> +	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
>  					&prox_state->common_attributes,
>  					prox_sensitivity_addresses,
>  					ARRAY_SIZE(prox_sensitivity_addresses));
> @@ -262,7 +267,7 @@ static int hid_prox_probe(struct platform_device *pdev)
> 
>  	ret = prox_parse_report(pdev, hsdev,
>  				(struct iio_chan_spec *)indio_dev->channels,
> -				HID_USAGE_SENSOR_PROX, prox_state);
> +				hsdev->usage, prox_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
> @@ -291,8 +296,8 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	prox_state->callbacks.send_event = prox_proc_event;
>  	prox_state->callbacks.capture_sample = prox_capture_sample;
>  	prox_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PROX,
> -					&prox_state->callbacks);
> +	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
> +					   &prox_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
>  		goto error_iio_unreg;
> @@ -314,7 +319,7 @@ static int hid_prox_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct prox_state *prox_state = iio_priv(indio_dev);
> 
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
> 
> @@ -326,6 +331,10 @@ static const struct platform_device_id hid_prox_ids[] = {
>  		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>  		.name = "HID-SENSOR-200011",
>  	},
> +	{
> +		/* Format: HID-SENSOR-tag-usage_id_in_hex_lowercase */
> +		.name = "HID-SENSOR-LISS-0226",
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_prox_ids);
> --
> 2.38.1
> 

