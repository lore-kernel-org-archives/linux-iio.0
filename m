Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154421;
	b=Y4fWZ0bypJrGXYIzQPtlVPznPEH/Yk66HeoXxTsGbuc6NdWioz7THdpqvy9VTu6WFbSl
	 wRrJ9KFvyMr8DcqUAGTJit8xr9f7fzePnH4Ny72J1kBI6rQCiQqYnyQJaUL69+O0sAjMM
	 EMIgJoa/v638m4qKGQuNXkijvQP2TaXTjEQctFBklOE5mFWtMLLqPb7psgxWsbgUX2am4
	 bxQSlzoFEKCdbRZEutrJqYi77MT0poX6v2drq+HoqOu42zp/Yb3nQXqvNYNdg+WjftIMg
	 osa2GGqHBZLcD6jOHhpRNmqQ372qn6bHFxFQBRfLHogUyyZSsYZZAEgbNh1vtH6pnVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dztU/TExvRdwdoHHA1pmOA03tC4CKeaHgrcXA1r9kN4=;
	b=cydwSj3C57H+61+76W0uyVNPfSg6QzcRk103qeHYIWK4F7A8GAvTIQVtIaQfOdVQeMGg
	 608GwGH3i0lkrytdv3pXC7mHbOVA4DyS22Kr3ZcPIQg7rjc0UAdfG+NDcLC5qshVUdJoX
	 44nhGZQjpJCrfCHd1h+qykM4OnsALYPhhiYHn9+bQyj7XK+Y2TxqGUpFbaOd0Bg23uQ6s
	 5e8sxoxLkb+BA9HaUZSNTOz8wKWgBEqjwZkFMCNcB8iFKWUJgPxr1QOCvK2YNboFPiONb
	 Ow6+9sq3HHTptlhqsnsrxOgmd5qYkk0aBK1cf6z9fz28IVeDRlFq2/iZKie9Gi9YoLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6u4ASHA;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723E606A31F
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C723E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6u4ASHA
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1325853e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 19:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154420; x=1793759220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dztU/TExvRdwdoHHA1pmOA03tC4CKeaHgrcXA1r9kN4=;
        b=q6u4ASHAlu96sY2ofBItUFB1lKaUWqtlWcAjq1ouApqcY9t1yw/Wh4kibHPEDawxFh
         VksZEMuoeQxaWyIEf9SyZnbklSAYVChDgCLG/EQLSM8ltiILoRoF26o4QlDAPXW1Vl5Y
         ahbBNd2ed5e4dZ4wFAaoDVIOUJCVkV5M6rl2KuVq1HavhyAKFN7RdW0BaimAwmGBstIt
         BgfJFswec0DhT2mz43ls7KM9phFFtq1ThmmvFaas6zEnLYqrz5TYaZhpWAOY4hdTsSke
         ZTHX+2th4s8+FFHJOeX7b42JRpdmDBCW7gSVzBnSC+qqc4yLX/f27lS+9cYM0lomxpio
         b5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154420; x=1793759220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dztU/TExvRdwdoHHA1pmOA03tC4CKeaHgrcXA1r9kN4=;
        b=hvsAPHXr/34GrbYoOkks/0q5jLPSO/TGn9gTq56AsAa7QwS+UDccqckGQuFurFrJ4S
         L4psb4tMDX8ErCEVvJ4YUbxfSYqs9r6q2JcxUQshRbZ8sZyffy3siRk8AFZgF/FaAy6+
         +5Cv8D5szuowTEVzR+SM7UTgygFFymao3f4gg/5WEV+RJGJCDG8rSHQgwRsQGztsURtU
         pQg4GsqVvfZ72zIryxZJfhD6hKysB87RNmLUs18hEXx1Qm9msWnqdsP183Ufwkqh+LOs
         GzpmMOrJR5N7O5eaAlICVZIHUBxst6mG4EMEOhS3fFqQK/0Nu3GPxRbUF9BGYCF9rsG9
         m2+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxU9dONSK0a4WtM0Ydoze+HPN+L39QUgdx+D7Vwt558RF2r9SvSuJooImp/7+SxnCnNcH/chEXjWDg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVrBA2urVrlZKBpZS9c5ThfAQjfV5SXe/GtduvyZqO8s0/3v8z
	Zs2atgMt0JiWslFYzmxD1db2lHNCrEPiuTt7BY1YW4WHjvIeOCCeDu0w
X-Gm-Gg: AYBFou0qDmAxiU0QT1nRYKQpKABJHCLppqq1Kwg+Ms69Dv8V35A7961wcNy8J1XEcqM
	+iWZJJOK+izeyGKaKSoNhA88lVOfzW3UqnVGTfDzFhCQdCoDYsjFD+QWFQiL0cMxTsObm3DspjO
	QhdEHrGlB3vPqkk4m405ShpALyb1m7P5rT2xosgUl2jBQdCyR7v95p5AxRkKT9DnIb/SZgkjKWi
	8yr7WzJ1YQzIv5RhIxY5PEWJbF7dPHPy9ngancqLwEYkXsIh8zthSYzIcnYpMpkUNfvlzqWA0GW
	GfGIV9esdQrlnX2jYmXwUqDsvYAwbH9DU0pESmGkPzL15CFfDcDR82iKIqtdQY3oVBC2sp1UCIW
	Yl35L/zf1YQnPAKJv9oRA3F86mU3fR8ZJ8Y8NWbli6PIgQhlNbvrpBYFbeJ5KYaESW5MLRFSDeb
	doX/aewVwci1600mUFSOwdKKlyiQQbfqVxnU8wlFyhlq/XZ7nUBaosXnS115wk2yL9lNWorCq38
	4CN537eghvgUgMhvD7y7uBuV1CWhi846oZpJ7lLlGAO/Rs73L55HDtbnmsCCLxLB9ihZGOieHuQ
	+ZLW4DUH9zzC4UqSJLryc+wW7t9dCg39bIG2DD7rArVdOgM2j7ro
X-Received: by 2002:a05:6102:41a3:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d041913706mr48618137.6.1793154419656;
        Tue, 27 Oct 2026 19:26:59 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:4df:52dc:4559:394e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3824sm4456693137.4.2026.10.27.19.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:26:59 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: adc: ti-ads1298: add ADS1299 support
Date: Tue, 27 Oct 2026 23:26:52 -0300
Message-ID: <20261028022652.31121-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025233429.23b02702@jic23-hlaptop>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com> <20261024231335.280955-7-stephanbrrs8@gmail.com> <20261025233429.23b02702@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 23:34:29 +0000, Jonathan Cameron wrote:
> A few things in here feel like they should be in precursor
> patches because the implication is they apply just as much
> to improving support for the ads1298 as they do for the
> new device.

Agreed. DVDD and PWDN become ADS129x patches, binding and driver, before
the ADS1299 ones.

> > +	if (FIELD_GET(ADS1299_MASK_ID_DEVICE, id) != ADS1299_ID_DEVICE ||
> > +	    nu_ch > 2)
> > +		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", id);
> How do backwards compatible parts with fallback compatible of ads1299 work?
>
> Generally we don't reject on simply an who am I value mismatch.
> Note the existing driver may need relaxing on that point - we used
> to do this before DT maitainers pointed out what it broke!

Today that works only within a family: the channel count comes from the
ID, so ti,ads1299 serves the -4 and -6, and ti,ads1298 the ADS1294/6
and the R parts. A part with a new ID is refused, as the existing driver
does too.

For v3 I'd do, in a precursor patch for the existing driver: the
compatible's chip info is what the driver trusts. If the ID is a known
part of that family, it still gives the channel count and the name; if
not (another family, or a reserved channel code), the driver warns and
goes on with the compatible's chip info. The channel count from the ID
has to stay, since ti,ads1298 has been the only compatible and existing
boards with an ADS1294 or ADS1296 depend on it.

Does that match what you have in mind?

> > +	/* The ADS1299 comes out of reset with its inputs shorted */
>
> What is the case for the ADS1298 - is this just harmless or does
> that have similar behavior?

Harmless. On the ADS129x CHnSET resets to 00h, normal electrode input,
so the write changes nothing. On the ADS1299 it resets to 61h, input
shorted, and without the write each channel reads its own shorted input.
I'll make it ADS1299 only, through chip info, unless you prefer it
unconditional.

> > +	for (i = 0; i < indio_dev->num_channels; i++) {
>
> 	for (unsigned int i = 0;...

Will do.

Thanks,
Stephan
