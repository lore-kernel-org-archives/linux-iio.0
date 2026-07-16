Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823893FE653
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213752; cv=none; b=aaDcTvCxq6uRynLsB95MU/2YrgAkrHqPT+LsMCsCMBbobh7OIUY+zH1C6Ks8kDyhCKuVKSv5Wa9E0PSwQYUuiPQX44FPbNla6JPm1f6Yg+cJPAzhNZhd9nKwHDFQ/tkwQ4Pqrv9bWWAIBv5wgNvVUjzo31jBjGsKbiS3JLPlh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213752; c=relaxed/simple;
	bh=s35wSUwqto+NRFA80vc1iCeqvAYogfjiVBLeG8kB700=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTzgREDHTgM6TtnSkmIjylXpotnlSAjHezOrhHb8F8CGuYwtFMsNkSq/avrwrAQIj7+n7ZAqZ1nT10QqlVt0qMyxAevbnkIWxPbYY62CrM/TJ/K3doAReHRI5GTw2tif5TQC2FlXjb58fUzoJlvbk6bUqV5BmAIXt89vKNAMVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=C+OzxW2O; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="C+OzxW2O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2/0urSarTHkNOB5KyyEOW1+7ui+1hTlDHXbKYtYIc/8=; b=C+OzxW2OuMYHSo28kbsZ7MLMYI
	g2hzTQdKf+ZTf+g+VV+tYov2OGembI3fWDTuqZU0QzPjSV7k4A1SPMoWOqnXSGv+5ggecxRGNXci5
	l+5+iE3hDepqR0Lq7gK570jVVq7DyunSDKdqdNY+/oOhgKZOFKOTwL5O1+upvkjF5s8M/nAzWGbJn
	dVD4Brvq0t4PnNUzhT9F7kmPgR0NCinqe6Cjq0zclf9JRgLOSvwQE9ZiDGfpsxfTAo7ioQQlDQSn8
	tz+7Ut3JhnmufsWZQRyXnqHRY06mhYFF61J5lnCLXNci5fEnVjIA7afTvD+gij/ZDOomNnOxy5bu8
	crM1Bomw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lars@metafoo.de>)
	id 1wkNUt-000Cnl-1K;
	Thu, 16 Jul 2026 16:55:35 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1wkNUt-000IDo-29;
	Thu, 16 Jul 2026 16:55:35 +0200
Message-ID: <5e9b7479-ed16-48aa-bd4f-26abc09e690e@metafoo.de>
Date: Thu, 16 Jul 2026 07:55:32 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28062/Thu Jul 16 08:25:13 2026)

On 7/15/26 5:57 PM, Jonathan Cameron wrote:
> Resend to include linux-iio. Sorry to all who get it twice.
>
> This came up in a recent review and I realised I have been giving incorrect
> review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> the dma safe variants only ever return either an error or the full buffer
> size.  Short accesses do not occur.
There is actually one interesting corner case. If 
i2c_transfer_buffer_flags() returns 0 i2c_master_{send,recv}() will also 
return 0, in which case the updated drivers will now read uninitialized 
memory. Maybe i2c_master_{send,recv}() needs to be updated to translate 
that to -EIO.
>
> This series (also my first upstream series prepared by poking claude)
> removes the redundant checks from all IIO drivers.
>
> Thanks,
>
> Jonathan
>
> Jonathan Cameron (22):
>    iio: adc: ltc2471: Remove redundant i2c_master_recv() length check
>    iio: adc: ti-ads7138: Remove redundant i2c_master_send() length checks
>    iio: adc: versal-sysmon: Remove redundant i2c_master_{send,recv}()
>      length checks
>    iio: chemical: scd30: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: chemical: scd4x: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: chemical: sgp30: Remove redundant i2c_master_recv() length check
>    iio: chemical: sgp40: Remove redundant i2c_master_recv() length check
>    iio: chemical: sps30: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: dac: ad5446: Remove redundant i2c_master_send() length check
>    iio: dac: ad5696: Remove redundant i2c_master_send() length check
>    iio: dac: m62332: Remove redundant i2c_master_send() length check
>    iio: dac: max517: Remove redundant i2c_master_send() length check
>    iio: dac: max5821: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: dac: mcp4725: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: dac: mcp4728: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: light: lv0104cs: Remove redundant i2c_master_{send,recv}() length
>      checks
>    iio: potentiometer: ad5110: Remove redundant i2c_master_{send,recv}()
>      length checks
>    iio: pressure: abp2030pa: Remove redundant i2c_master_{send,recv}()
>      length checks
>    iio: pressure: adp810: Remove redundant i2c_master_{send,recv}()
>      length checks
>    iio: pressure: icp10100: Remove redundant i2c_master_send() length
>      check
>    iio: pressure: mprls0025pa: Remove redundant i2c_master_{send,recv}()
>      length checks
>    iio: pressure: sdp500: Remove redundant i2c_master_recv() length check
>
>   drivers/iio/adc/ltc2471.c              |  2 --
>   drivers/iio/adc/ti-ads7138.c           |  4 ----
>   drivers/iio/adc/versal-sysmon-i2c.c    |  6 ------
>   drivers/iio/chemical/scd30_i2c.c       |  4 ----
>   drivers/iio/chemical/scd4x.c           |  8 --------
>   drivers/iio/chemical/sgp30.c           |  2 --
>   drivers/iio/chemical/sgp40.c           |  4 ----
>   drivers/iio/chemical/sps30_i2c.c       |  4 ----
>   drivers/iio/dac/ad5446-i2c.c           |  2 --
>   drivers/iio/dac/ad5696-i2c.c           |  2 +-
>   drivers/iio/dac/m62332.c               |  2 --
>   drivers/iio/dac/max517.c               |  6 ++----
>   drivers/iio/dac/max5821.c              | 14 ++------------
>   drivers/iio/dac/mcp4725.c              | 22 ++++++----------------
>   drivers/iio/dac/mcp4728.c              | 13 +------------
>   drivers/iio/light/lv0104cs.c           |  4 ----
>   drivers/iio/potentiometer/ad5110.c     | 18 +++---------------
>   drivers/iio/pressure/abp2030pa_i2c.c   |  4 ----
>   drivers/iio/pressure/adp810.c          |  4 ----
>   drivers/iio/pressure/icp10100.c        |  2 --
>   drivers/iio/pressure/mprls0025pa_i2c.c |  4 ----
>   drivers/iio/pressure/sdp500.c          |  4 ----
>   22 files changed, 15 insertions(+), 120 deletions(-)
>

