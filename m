Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795857729;
	b=3ouaprsClNVlqlymQNXguWPj7fKG0uUNrOkIBvT/Hb8OQb82zkDXCBpdEeQsKV2wnCun
	 Tk5TetkbGAWktBPhcqdt6JDf2LkiTqcdhKfRi4YeTt+TguGpWgYJTDhYszP6yC/atzkoB
	 4+38agycZCSqCPABNzzUFfQ8u2nRmNEsM5Dey02/p85qJLtS5x7D4PERq0eRxjEN3gKtN
	 iOM8rXXu6KfRx7EnRNF1+pHBM/jpEd/iz/IkFkxGlovEKFr5EmjYk/XBWD6KglivOi19u
	 77uRj5tsKaafXvbRgVGx4tNrhb3hkwZVuWxGrUwa14rftCLMDN0wAdB/hT2DitzY6HA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795857729;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wlckpMJ074/wY0TNt41XHzSk8RPHuKfXuoWeAZ7xaY0=;
	b=0HXkgcC1xFRVzoiqV8s9J2EaQRDZgpDBLOpldzrpGTmKB7SuMYhEu40UzIs7z7Ho2D2S
	 W6fEBgsQaQRMElwbCJq9dSepcV2+KaWs3hB1YUZ3QfcpGJ4WowbPi2dfEKIt3uGOTUHLx
	 +GBDNqpWmRos0MujjsiDK85savCjXSAnnq54Lo3IzLaOkq7/IfiWOJV6t+NZtwKxMmJ4T
	 AASu5Oxhf/pIq4glxKNr69cPTzQCzIVhYdrzT6NnF25PSEM95Tpg5PdErjQf+KYOA9ikF
	 oldyUA8PALPxlFk0ihV5xH6BzAtwD5A3Ix/N1VZjcRryzB3TT0EpFqs9RV4c2jOdPBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redaril.me;
	spf=pass smtp.mailfrom=redaril.me;
	dkim=pass header.d=redaril.me header.i=@redaril.me header.a=rsa-sha256 header.s=zmail header.b=gZvnawq0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.18
Received: from sender-op-o18.zoho.eu (sender-op-o18.zoho.eu [136.143.169.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A1606A323;
	Sat, 28 Nov 2026 09:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814A1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redaril.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redaril.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redaril.me header.i=@redaril.me header.a=rsa-sha256 header.s=zmail header.b=gZvnawq0
ARC-Seal: i=1; a=rsa-sha256; t=1795857688; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TrHrhQJMjSLKmgtcrGYeI8/hpod9FxQkl++KebPmUenmpVKOGxKhi5xfrGvuYEP2tlOXZu1131syz2sUOpknAnUUyUApx1cQMOmzBSlvpHvL+Mj8UBAFoswMprm69HFTM8QbnmO9tqrWzs+kQNXd1ROjJZeoPb7frXe9i2QxvKw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795857688; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wlckpMJ074/wY0TNt41XHzSk8RPHuKfXuoWeAZ7xaY0=; 
	b=fh86+1oTVSIirsHzrNQK+4U8mBUOtU6TZdeNG4xl3mtZp4tnBqFTGz0U+O8bWnUzf7eQ22DniQVzXIwXWfpg/d01git94hKsgAlR/fjj/GtMYjdwVp++Ahj+lABzfQhqdmDZi3eto49XZIDNq7ydq159PnudrPBKJbLz20bC4+c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=redaril.me;
	spf=pass  smtp.mailfrom=development@redaril.me;
	dmarc=pass header.from=<development@redaril.me>
DKIM-Signature: a=rsa-sha256; b=gZvnawq0Y8vfoCXRTSIQE9oKTGrgXth7zsKTkAXyNn9pIag8EP32d9sHrlbL+TJzoi+FCLy/bzpMz1UhJby8voQqaGgHZS2gTql5YfHzIcldQDiHb/SQSF8x9a5w+STenJQOayRn5rj2qB8Z2uxppvwE3IEVj37DnK0jOg4Zuas=; c=relaxed/relaxed; s=zmail; d=redaril.me; v=1; bh=wlckpMJ074/wY0TNt41XHzSk8RPHuKfXuoWeAZ7xaY0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795857686218484.3481136278716;
	Sat, 28 Nov 2026 10:21:26 +0100 (CET)
Message-ID: <bad51b29-1bf5-4603-ab63-bdcacc7ffd06@redaril.me>
Date: Sat, 28 Nov 2026 10:21:25 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: afe: iio-rescale: Add platform IDs
To: Jonathan Cameron <jic23@kernel.org>,
 Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Cc: development@redaril.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20261128-iio_rescale_platform_ids-v2-0-4c35f16c4f77@redaril.me>
 <20261128-iio_rescale_platform_ids-v2-2-4c35f16c4f77@redaril.me>
 <20261128003010.6b36fa7b@jic23-hlaptop>
Content-Language: en-US
From: Fabio Forni <development@redaril.me>
In-Reply-To: <20261128003010.6b36fa7b@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/26 01:30, Jonathan Cameron wrote:
> On Sat, 28 Nov 2026 00:22:10 +0100
> Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org> wrote:
> 
>> From: Fabio Forni <development@redaril.me>
>>
>> When a rescaler is dynamically instantiated and configured with swnode,
>> device_get_match_data() will always set rescale->cfg to NULL, because
>> device_get_match_data() is unimplemented for software nodes.
>>
>> Define a platform_device_id table (a replica of the of_device_id table)
>> and call the platform_get_match_data() helper, to deal with both
>> swnode-based and non-swnode-based instantiation methods.
>>
>> Signed-off-by: Fabio Forni <development@redaril.me>
>> ---
>>   drivers/iio/afe/iio-rescale.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>> index c01292a15a29..c268dbaaaea6 100644
>> --- a/drivers/iio/afe/iio-rescale.c
>> +++ b/drivers/iio/afe/iio-rescale.c
>> @@ -518,6 +518,21 @@ static const struct of_device_id rescale_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, rescale_match);
>>   
>> +static const struct platform_device_id rescale_platform_ids[] = {
>> +	{ .name = "current-sense-amplifier",
>> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[CURRENT_SENSE_AMPLIFIER] },
> 	{
> 		.name = ...
> 		.driver_data = ...
> 	}, {
> 		.name = ...
> Or
> 	},
> 	{
> 
> I don't mind on that bit, but use a few more lines to make it easier
> to add additional fields in future and generally make it easier to read.

Will do, but to be honest I always have a hard time syncing with
maintainers' own style. Why isn't clang-format style simply agreed upon and enforced?
Automatic formatting would reduce cognitive effort, and chances to argue :)
I think Go and the Black formatter for Python did the right job on that matter: one
style, no questions.

>> +	{ .name = "current-sense-shunt",
>> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[CURRENT_SENSE_SHUNT] },
>> +	{ .name = "voltage-divider",
>> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[VOLTAGE_DIVIDER] },
>> +	{ .name = "temperature-sense-rtd",
>> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[TEMP_SENSE_RTD] },
>> +	{ .name = "temperature-transducer",
>> +	  .driver_data = (kernel_ulong_t)&rescale_cfg[TEMP_TRANSDUCER] },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, rescale_platform_ids);
>> +
>>   static int rescale_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -548,7 +563,7 @@ static int rescale_probe(struct platform_device *pdev)
>>   
>>   	rescale = iio_priv(indio_dev);
>>   
>> -	rescale->cfg = device_get_match_data(dev);
>> +	rescale->cfg = platform_get_match_data(pdev);
> 
> Can we get a failure here?  Forcing a driver bind to a device not in the tables
> tends to end up with NULL and it is common to just fail probe if that happens.

No problem.

