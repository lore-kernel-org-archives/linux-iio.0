Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C47572673
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884996; cv=none; b=pRNZXlpMtQ3scDPuOShnGhWBPVz54tvynT9whjsJhlzDgugS4loDcVhXWJwW+NSx80POZkuC1IUCS7rcButO+WhhZSgYZKwB71YEtMrA4BMi+4cfo3cQMHUjXmGyDwJ4OOh2xwhgUKZpnkrzvyroiN954XGLr/dEKeXmZNH9pAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884996; c=relaxed/simple;
	bh=RwuYV9Sl7mHmb36wZxRTPspRiMkOGbxObIiEG/b6AVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgW+AUa0H8hhCGnef272i86kPtCp4/vjIzC0k8Dy2XdGG9yifGb9EU6PrNAecNKOCROupb9JmYsT9CYfDJLLjpFFXxW7MTsecsGxQMFXBHmaKzltmCRM2iJTHIjdeYB2hnzkKU7grbRWd3JiF1t02bK//IDBj3ExR8PU0LwS4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI+NeGIq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI+NeGIq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so39275515e9.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884992; x=1789489792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1OL80AMZio9aS7yB2uFhxd88x92rOLpg7Akucp7hrI=;
        b=iI+NeGIqExsX8Oc+DF4Cu8olO/QHCp3RYZDbADI9rOQxZ8TcL4fdOoJfnRy7ct2cLX
         xFHto9nE0eEs5cc/WZ3KCi1vo+d9LU5R8zWLLge9L69cN+B9EBNxgcTxoLWYePaSMikD
         A5SJTqvLyqNd/j32ZlM2cGAKNbjYj9kXv5VawcKibUIMqJbC0v84FhIvAOuNW9RE9JfH
         2qZENa7u8BI3ouWuhLZDby0Z5kgZGI0eX9yjH45Dg1My96SmKaHmR1uVFBrQdfrH3No6
         uDi66/MlOYZIShR/ZKZ9JO6NKr/HG2Fkoc4Wbxq15+64uVzA/0KItiG7ChWvCp3yJXNq
         DnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884992; x=1789489792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1OL80AMZio9aS7yB2uFhxd88x92rOLpg7Akucp7hrI=;
        b=iqgojqY6CTvrRbIzNZrCab07HgL5+DjCjMDruoMDm5qOYdW0d0874N/M/f2f1o0llt
         b7XmZn2n6yfcpfu4gO8JiG86rRo/H4eqSMk+iZkgDQFB2VGMezRG+C65574rkVDrBCE9
         tQhJ2MtMjZmTjoXGdLQU8UQDgKZhPBl5G/6S4MQMauQNQSkDju9NRf7gChoibv2l8pK7
         JUMyCZ3QnILOzQk9Q3r0PL9ldlt0gc0TKTYqvUUmxgPghNzg3u6VYrMUMq0XqhvH27Fo
         jDxZ7tsFrzrvV134e6Bg7fTUU5di1IgvVfP5Daj56iNHC2vheuI38lE6/YwyClID9i6O
         HSFA==
X-Forwarded-Encrypted: i=1; AKwUvBzwpo9OELSqC8NcT6z5GZTGqDVLeDhX+PYsJNuMnMroR46pMR5MuReIPwpbhFIvGNLuufU528neNX4=@vger.kernel.org
X-Gm-Message-State: AFuF++m4/FNCpT3cvhC9zLW/VBkL8DdE9KW5hMlyyxARjRxnQp4TwlCf
	I2j1mzT3obOcbURM3AEhK7f5eiqkGAccEnyIpVWSe6iIkuRX+SX/eASA
X-Gm-Gg: AYBFou3P8IPAf/IaZuxJd0+48nsFEkDgdlf+POJtH7r2PJIV/N9TazHDc5eDh0GMINc
	CYGw9vQBRiAK+m6fnDeqEXxp6Bfti0zRy4iO8PN1VJNzZcwSRS1OGgTBlahixvS3sMD3GGpcO8Z
	7PyTO0uU2X8QoHMNMw5z/YWUVYW3FG/h7pUS6swt6/dt4vuQZlLIdPegdDTKdcvWmCsC3UpyUFU
	fY813oi70trBUINEPn7jTdJBwZvT3v2Z9Njr23AzJc8LrEf6tGhawis5KFA33tRZx2+8ZF3Lr4t
	ZTZRoHcIumhgDFalLMIHEnL03LTyBVLiHUjtJzel+rWYqBLUg1M47MGrnWtpwdXxJDW9GpQudc/
	dWbNDIz2dDrkQ3gmagEiL58lgM5PLMavdoBy6SN3Oi4ozdDM1JlCRKySIM5euqU3FCdw7olerdF
	vmKlmGg33a0k/uDCU4KMZ63sZsQ+nhPzAdsM8cPMLheUps6G1cOa0mY9DI/OWdprfJCabV26mAm
	GKzH/Ao6QB6vwZkgCRy9pIUc3gfrxG9iXC5g/pBbQ==
X-Received: by 2002:a05:600c:46d1:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49cf820c992mr311945925e9.6.1788884992168;
        Tue, 08 Sep 2026 09:29:52 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm571758155e9.13.2026.09.08.09.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:29:51 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1015: Add support for label
Date: Tue,  8 Sep 2026 19:29:47 +0300
Message-ID: <20260908162947.5446-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ap_kA8laT70faM9B@ashevche-desk.local>
References: <ap_kA8laT70faM9B@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:31 PM, Andy Shevchenko wrote:=0D
>On Mon, Sep 07, 2026 at 06:23:04PM +0300, Flaviu Nistor wrote:=0D
>> Add support for label sysfs attribute similar to other adc devices. This=
 is=0D
>> particularly useful because the label can match the schematic signal nam=
e,=0D
>> identifying channel voltages easier if label is defined via device tree.=
=0D
>...=0D
>=0D
>> +static int ads1015_read_label(struct iio_dev *indio_dev,=0D
>> +			      struct iio_chan_spec const *chan, char *label)=0D
>> +{=0D
>> +	struct ads1015_data *data =3D iio_priv(indio_dev);=0D
>> +	const char *name =3D data->channel_data[chan->address].label;=0D
>> +=0D
>> +	/*=0D
>> +	 * Avoid printing "(null)" in the console in case label property=0D
>> +	 * is missing for the channel, or channel is not defined.=0D
>> +	 */=0D
>> +	if (!name)=0D
>> +		name =3D chan->datasheet_name;=0D
>=0D
>Is the datasheet_name static? Can this rather be made only once=0D
>at the probe time?=0D
>=0D
=0D
Good point. Yes it is static, so indeed I can move it to the probe function=
.=0D
Will send out a v4.=0D
=0D
Best Regards,=0D
Flaviu=0D
=0D
>> +	return sysfs_emit(label, "%s\n", name);=0D
>> +}=0D
>=0D
>-- =0D
>With Best Regards,=0D
>Andy Shevchenko=0D
