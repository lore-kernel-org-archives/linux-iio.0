Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7E1DD525
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898041; cv=none; b=oNBdgXuRo5VAB4WQaqo2XTiXWLyHA2LpcAX99S3ndDNfn1ClPX1piooL7ySqAH5GEFUDKi4sJU2A+06Lz+slPNUsIhf5V/uYi29I6X7aaVS2KngSmNUWjk2cTFNauZuYKOmkP8ZmA20RK2tPvShcZnXg0rnXW4aVMmHJseY26F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898041; c=relaxed/simple;
	bh=FREm71o6dPjk31ExHIEHYZuqEUeAt9RXIVG2nH9eNm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oNLNwxkq99E63mF6fXxUHeWQ6IWQFGnbqFA3Zkgz0ww2Rqviqw/e1oQbNjaKK675yJuaK+0C8b+0I+6xmitX7PcTPQcKuMUT9SPv+u6ILk89ohAnub+H3ccGjQrffx4DEaDA7DcMFqxZx16/2D0nQRU8dX2IkzDV4vgwaVvANB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=7rlzOgsz; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="7rlzOgsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787898029; x=1788157229;
	bh=72FNFjvXuvv7RR0zBq6mGBBDujFULPjmI+aWuE4Uis4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=7rlzOgszNoZmv4MAFiSALgtSUmnSUu1DrzEW19ikt7BmCqMZ1ulGPBhX1SShgrKVN
	 Cc7fraWr5r+wiQXBC1U3b7ss8C/+0LXfiS+YIlLXgNdijNnIy6TlWzZeQHF1Bt0Aws
	 cupOlKoO6IidiXp3IAhbJ6lsE2dRhAeqMZZbByRMV3kio7SYtym1lN7PBNK8XBnrUB
	 wS6C7OsS+kme8rwTSSC7/JKPj3ei/w4RLy8A3N0V/seimEE51MPJagCaeSj26fRUr/
	 UrmxjIVD5Q5Ch6UvzWnev754bj+q8EvxGLoUUFRht5j3B2k/IvXRllW4doTw5As3Yu
	 vUIwP9INvy9cQ==
X-Pm-Submission-Id: 4hWStL36Yxz2SchS
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,  "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Joshua Crofts"
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v6 6/9] iio: accel: mma8452: Reuse existing dev pointer
 in mma8452_probe()
In-Reply-To: <ao6Vbm59IX1cl7tj@ashevche-desk.local> (Andy Shevchenko's message
	of "Wed, 26 Aug 2026 10:27:42 +0300")
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-6-9b252804ee80@geanix.com>
	<1lSq7y7LYcNpJGnkxSN5o1d9skFu9meHSq1iRHldMT9IJT8osgJ8U-ZkfcufpJRVR-2vXYISbJUQhkFo5QIHcg==@protonmail.internalid>
	<ao6Vbm59IX1cl7tj@ashevche-desk.local>
Date: Fri, 28 Aug 2026 08:20:25 +0200
Message-ID: <87bjamzryu.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Tue, Aug 25, 2026 at 10:27:44AM +0200, Esben Haabendal wrote:
>> In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
>> struct device * pointer was assigned to local variable dev, so we can just
>> as well reuse that throughout the function for sligthly more readable code.
>
> ...
>
>>  static int mma8452_runtime_suspend(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>
> This change is unrelated and should be as simple as
>
> 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> OTOH, this might require the full device.h to be included...
> Either way, it's not for this patch.

It is dropped for next version.

>>  	struct mma8452_data *data = iio_priv(indio_dev);
>>  	int ret;
>
>>  	ret = mma8452_standby(data);
>>  	mutex_unlock(&data->lock);
>>  	if (ret < 0) {
>> -		dev_err(&data->client->dev, "powering off device failed\n");
>> +		dev_err(&client->dev, "powering off device failed\n");
>>  		return -EAGAIN;
>>  	}
>
> Why? Just use given 'dev' as is.

Next version :)

/Esben
