Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F931D6DA9
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784508937; cv=none; b=d5boBQAOriUIabhLm64+oHziAfoZPXDLUr6tVz3HyZ1NlyqByAlw+AGUENBdKfdQVRCqsGLHByrvAucoJtLjHFcLmOD8MJRCpKH9iSdb+t3Gjm2XrHBTAbNh/2eeoig8w9Zn3mm6QxSqQ+pw3BrtScaR37N16oR3/wzXNI+3m6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784508937; c=relaxed/simple;
	bh=VYUkCWQuG8/KJqlHmM1Pj70tvXSM4Ihz5MTh7te4/q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTP7oXrmE5oTxTaFXPRbknBR6Z+/t5k7EWm3Ngb8Vx6SFF2XK9Iy6F79+8FaZcmZlzCN61xFek7QKzt6iq+kvFBkardNSYxVHsLuSUZBAtv6wRrELcHqJ9Ki65wtzw3zDSlaq4VO8q9OEtYEUMzzLjZFyADaIcSZ9DMufjdg3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cKmuOqcZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FB7Va7HO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKmuOqcZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FB7Va7HO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsGYl803528
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6V8CuGzHGXoJURAt4SDpDqNmiiYOtTmZFicDejSPp9c=; b=cKmuOqcZ8u6YHNu2
	+O/X6oX5+IWUd3q0cgJf1pKo3pcsegtoL1esJT/rVX6uym2AM04vuDMzl8MirCvF
	YoirH7k7am+4v7QpC94/s+6cI13E2S7gTG55F9nEdoNNQzgec14X5lYfzXRqEgTU
	Bh/ZB7DG7JylAs29vWwg0t4oRDaZei/y/I3nO9/dgLdkg3MvUxE8AtrTmk22YLJ1
	d/VXagUKdprzawN2p1OF2pklI9cANbyaJLRPGyuufMCGRpvqkUFq0p5FxjHU6u/S
	GYVXHNpyyVByYUV4FIha5ek+y0VNintaaMm+Vs1kQSu9M4fQsaHZaCLcCLC+4p/P
	WSzaOw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04ts9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:55:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e6d253330so913321a91.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784508933; x=1785113733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6V8CuGzHGXoJURAt4SDpDqNmiiYOtTmZFicDejSPp9c=;
        b=FB7Va7HO4dKDDTHIfKMtCjpo2WirCKNtB/vaWoIGHlBOIrnVVUSig2bisALhjjfqrm
         KCpXevweOY87uALalkfX+khiK9bEuZEYkoWUpVjG3AsrUFiqbbh/NWaCmssqANQbnww/
         mjidYY9V8isWe57DxuSyr1/0ibIiDMvv4xVi5y7xGNDUcpdi7TJlr+Ng4TanI2GqImCB
         FrFcqNno0GF0bXJe9/enL2+8XKiO57jkEHqmbvT/HSilowqPu18d3EIj3A0dVwJQdeJy
         Qf4QjU3MmwevUe6TlUBPdz+p7tHf9GN641YEd3BG08SXeEvFfnp6U46EQvEaP5ay/KBL
         FYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784508933; x=1785113733;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6V8CuGzHGXoJURAt4SDpDqNmiiYOtTmZFicDejSPp9c=;
        b=bBYghPZUiL8i4HLStVcmO9wl0uPmGPh+0LKgcWiE9YUaGCS7t7EG7t5NRTWmMJaNx4
         3u+sNZNBYw9EOSPor649ccBarul022alBUAv7SnLWJcJ+syz6jwjmpF0gsZWELa9uyXo
         dlohsdNF6oCNW3zW/8Zl+33UOKva5uNWMrDM9x1IQm4bAfx4EkIKZlxNPPZ0wPsvpIiI
         +LEixkXrg+OYSp8Ed2lzPKEAaMl7DKp1+PSla4ZYDqK4pkd5sF+fagXa5XafNwrpFzh9
         3OY2hZNRqnJozACcn+q1c9U7TpvwhVPlJCPQTOrVTNdQuhfAh3KGBJ/JLK11VR+JfQFQ
         EapA==
X-Forwarded-Encrypted: i=1; AHgh+RojvzIxEQij6NcwdTPu2qxKi7SKoq0XsRJIT2YKDeBJKz0lHns0C+ypuTG8gKbRCkWNkF4GHzcS7Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsZkD+ZiPLveWTn5ukJzwsHP2lcijiSXoy9jS76BpZxP3zv1/
	oNd9VFsXLoeF4Oc8uvRfVLtmXItDzyWcbcUEKPQPUAmyTwqhiN8yM+x6dhOhuuY/FdFrlhlqrYM
	muXTZ9gLYblLPLGE621xjz+ydo/ngErMc38CGSwB1NoKBCz2DhYJja5LrMdi2OYk=
X-Gm-Gg: AfdE7cmNP2/WjUsBUTv/QcauZhrMv0fqH0iH9nNgrffHGr6QUnIDAwA0dls4UCH2yTN
	lDg6Q4a0YQy0vvgag+KqIeQRO2hprShzdKJ6YThPSVPue467ntpPU9qwaual8bSaz9o0q3cs207
	n7LqkUMibjUcsp/BIOlwW8OhiemSwWLHpRtYXb9/ZL/uPvlTnjFLOrq3ZDa0RXUn7vMffeRAHg0
	vwwjN7DKcZzMRaV8qHLCiMsIK2H3Qr/Dj7ZIvaCUcy/QvtGejk5dwh0J9q4uEucoYyHAyHILQ9l
	FyY3iOmYg9hgsd//LcxxsrCIzGQuJeMuGDZety63cAmWUAHXEi5JGiWcZr7jsJjaEFig0Y+iUca
	LMBh2I1WjdrfZ+Ssu
X-Received: by 2002:a17:90b:3c91:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38e4e61a52fmr10821926a91.21.1784508932776;
        Sun, 19 Jul 2026 17:55:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3c91:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38e4e61a52fmr10821899a91.21.1784508932240;
        Sun, 19 Jul 2026 17:55:32 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39deab2dsm6746847a91.1.2026.07.19.17.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 17:55:31 -0700 (PDT)
Date: Mon, 20 Jul 2026 01:55:27 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
        Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
        Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads112c14: add support for buffered
 read
Message-ID: <20260720015527.0ccc543d@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
	<20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5d7206 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=IpJZQVW2AAAA:8 a=pteTUHka6Q4YKNZ8nnAA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwNSBTYWx0ZWRfXxSdUiWG3YOZm
 t3QoX/t7G+FoAM4W4NLGezPkqSR/b+ApxW6pKcu0k0DRKkuday1BaVrZJbRWCts0Krh3SMef1wY
 UCZGATKCW1mobDba5sqdydjXNficNF2sgxGxsnlvjVuGwXL3BOKJ1xsFcNmstBopY8WlT/3gLbb
 9ihztfG9M28E05JnIrg5XB0VttG+BYr+pvDzNkF+rvDSv2AWFUmEdQlbl9qRP+SmU2ANadb6iGL
 a27zlO29yM8PnI4RllNMrPgh7E1rQN3t+pXyZlbDRp+MXFwChn6rRsqT5qwe4Y6bI4LYsvSbfcf
 w3hQaizJoShm6jl7K19KQ/R+8WP9Z0zwyVatNT2cu45s8VOOaEiFeuGO+4ACv5iH3Q6h+65WuyN
 IzvEy4lVO59fqbkTilA2pc1rLogaUx+zWOFYApy1N1Res5kVBYoZSQYN8l7DxZsRlJ2o2s2NYik
 NiBmUNWX59nrjldMBcg==
X-Proofpoint-ORIG-GUID: qUkLCW9mrReGd-12nbMCKhFQf7GnPXdK
X-Proofpoint-GUID: qUkLCW9mrReGd-12nbMCKhFQf7GnPXdK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwNSBTYWx0ZWRfX7TO4SOOhGVqt
 sikMT+/BUAxWGlHWrSyiZfNxMCjaEkepZChUN/YuTenMz3I0VhT5dQvobZYtLg9T+ZoEvFZnIWw
 pFRo9SDWRRWQHTJzOi7idYaNlQd8hw4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200005

On Tue, 14 Jul 2026 19:19:32 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for buffered reads using a triggered buffer.
> 
> The device has a continuous conversion mode, but that can only be used
> with one channel at a time since there is nothing like a sequencer to
> support that in hardware. Instead, we use single-shot reads like we do
> for direct reads to be able to read multiple channels.
> 
> Support for continuous conversion mode could be added in the future if
> needed via a 2nd buffer.

How about enabling that if only one channel is requested?  I vaguely recall
us doing that for another driver (though I might be dreaming :)  I did
see your comment in the cover letter about it affecting timing and that
making life complex.  Fine to leave considering this for another day
but maybe don't suggest a particular solution here.

Talk a little in here about why you parse the crc on to userspace.
I think that makes sense but good to have a record of your reasoning.
We aren't telling userspace it is there afterall, it's just in some
left over space!

> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-ads112c14.c | 103 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 99ccacd6d56f..1404ca31324b 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -15,7 +15,10 @@
>  #include <linux/dev_printk.h>
>  #include <linux/device/devres.h>
>  #include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/math64.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> @@ -29,6 +32,9 @@
>  #include <linux/unaligned.h>
>  #include <linux/units.h>
>  
> +/* Arbitrary limit since channels are dynamic. */
> +#define ADS112C14_MAX_MEASUREMENT_CHANNELS 16
> +
>  /* Datasheet t_d(RST) - time to wait after reset before next I2C use. */
>  #define ADS112C14_DELAY_RESET_US 500
>  
> @@ -255,6 +261,8 @@ struct ads112c14_data {
>  	u32 num_measurements;
>  	u8 sys_mon_chan_short_gain_val;
>  	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
> +	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan, ADS112C14_MAX_MEASUREMENT_CHANNELS +
> +						 ARRAY_SIZE(ads112c14_sys_mon_channels));
>  };
>  
>  static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
> @@ -575,7 +583,7 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
>  
>  static int ads112c14_single_conversion(struct ads112c14_data *data,
>  				       const struct iio_chan_spec *chan,
> -				       u8 *buf)
> +				       u8 *buf, bool for_scan)
>  {
>  	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
>  	u32 reg_val;
> @@ -605,6 +613,22 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * When doing buffered read, we don't check the CRC, but rather pass it
> +	 * along with the raw data.

Perhaps say why.

> +	 */
> +	if (for_scan) {
> +		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
> +			 (data->i2c_crc_enabled ? 1 : 0);
> +
> +		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
> +						    len, buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		return 0;
> +	}
> +


> @@ -908,7 +967,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  		return -ENOMEM;
>  
>  	channels = devm_kcalloc(dev, num_child_nodes +
> -				ARRAY_SIZE(ads112c14_sys_mon_channels),
> +				ARRAY_SIZE(ads112c14_sys_mon_channels) + 1,
>  				sizeof(*channels), GFP_KERNEL);
>  	if (!channels)
>  		return -ENOMEM;
> @@ -1069,14 +1128,44 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  		if (spec->type == IIO_RESISTANCE)
>  			spec->differential = 0;
>  
> +		spec->scan_type = (struct iio_scan_type){
> +			.format = measurement->bipolar ?
> +				  IIO_SCAN_FORMAT_SIGNED_INT :
> +				  IIO_SCAN_FORMAT_UNSIGNED_INT,
> +			.realbits = data->chip_info->resolution_bits,
> +			.storagebits = 32,
> +			.shift = 32 - data->chip_info->resolution_bits,
> +			.endianness = IIO_BE,
> +		};
> +
>  		i++;
>  	}
>  
>  	data->num_measurements = i;
> +	if (data->num_measurements >= ADS112C14_MAX_MEASUREMENT_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "too many measurement channels defined\n");
> +
>  	memcpy(channels + i, ads112c14_sys_mon_channels, sizeof(ads112c14_sys_mon_channels));
>  
> +	for (u32 j = 0; j < ARRAY_SIZE(ads112c14_sys_mon_channels); j++) {
> +		struct iio_chan_spec *spec = &channels[i + j];
> +

Add a comment to say this is updating elements of the template.

> +		spec->scan_index = i + j;
> +		spec->scan_type = (struct iio_scan_type){
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = data->chip_info->resolution_bits,
> +			.storagebits = 32,
> +			.shift = 32 - data->chip_info->resolution_bits,
> +			.endianness = IIO_BE,
> +		};
> +	}
> +
>  	indio_dev->channels = channels;
> -	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
> +	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels) + 1;
> +
> +	i = indio_dev->num_channels - 1;

If this is different from doing

i += ARRAY_SIZE(ads112c14_sys_mon_channels); and using that above and here
(with a increment after to account for this) then add a comment on why.

Otherwise I'd prefer that form as it puts it in the same scheme as the channel
increments above.


> +	channels[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
>  
>  	return 0;
>  }

