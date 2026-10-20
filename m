Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792477776;
	b=FX7SPKRMN409C39UfPonS57+8cXSuHqSOBax9gtFgHQRs/H6AH0Ppr5xnjxNnf38KHPa
	 AIWlaDS1oBdQ4r/7gBC8asKLkySVJG43wc0zg5IH2zpkDgl0PCNmzHY1tTrJ9ispEo9pW
	 dK5ip736YvtGy0YLzEzm48+CiEHLQtPdIY+iXjEdn7nQ21056CRSov0XTmyias3cgYIjH
	 vNnXNiHIhZ78bshwq7n8PWgI03j9p0FTwHu/zkvcZDP4jL/yIRrxLTXIdHXnAYoQeuK+i
	 BFddwO1YOM+j8A16iFfmvZ5tDzYJ8J0iGmcFCYL8VHemyLCS7N0w0ZTSVk7OXqyOpBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7mkrcGya/k9xPQHP1kLMQ9K/TBFMnTEolY10HA2nCkE=;
	b=b3qdS98BnCrbqgzuXyISc7eBppW2rSJmQnR2PMH+y8g5wG2wgeWCEOWtK8WHJaqqi5/R
	 HCz26j6Q7yiysO3S+8f5i25F0tCfnMTTSyAQtmIHI18x8Pbt6lYR+OsFWJFVkjfp0FplG
	 QFYMXJLz8Ixa2v8HnCleemSZmDphVUdXKkRwgEBxITKC2mIJYViQa7iLOTNJ5ln7Z5897
	 XJgrFaaEmtj4dmlckcCGYX5ZBkFY8T/XEkpXv7EF/prEKYqHqjGIxU+R5LmdIQOGARk2Q
	 P5VT7sWMh3oF6n4UJ5P7HfaWxJL58xZpURZxJvxNWLd37lghe1xMCykx111lvwhWyUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elxf+78x;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A19606A31C
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 06:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elxf+78x
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e0d1da913so276191f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 23:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792477774; x=1793082574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7mkrcGya/k9xPQHP1kLMQ9K/TBFMnTEolY10HA2nCkE=;
        b=elxf+78xlaN2+qBalzGsO3OM9GsMJcfqAFceAUiMP7K0mNd8dmkJOJ1zW5+JYF4X/J
         504zjvb7Hv6ECN77kmPFPKyZQ/mWyW2KfWmxH+ZBVVxOf9vqrnOFz6DNPFCOLTfq6fln
         iiFckYDAELsvpzXTqW1IBovXl7qRaTidqmcOkPN7CoYGkNkGOf9jWXTvY36/nCMKlFun
         ulT7M3Y7xD0wLpl9WWjwUKE0DYqnmwuIR5H1TSUAx6mityFxreNIVd21bK0FTROpCyLa
         aYbtwFQur8V1eRS454QxpLWvGh4UoPqQGEIqA1KP33Nc8QfbNBNlieMiOntd3r1oC0v7
         DRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792477774; x=1793082574;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7mkrcGya/k9xPQHP1kLMQ9K/TBFMnTEolY10HA2nCkE=;
        b=g2TdgCN/ZJm/Viio/9yVHomf9SktDN6r6TZE3IgG++vd/ccPnFPNtpoCLMo4gCcta+
         7XegnXQqIZLYDcEmdw4N5Z6xRbVqidATADiBq+z/YcN9ouBoXCjRMQEaQSPHMvyn6HRY
         YXNdzJ1LqUvIVKVss+tuOSg/rul+tR7LFp1RWtaneG3w1URyrmT3plOYi0ZgABwLqw2S
         uzxmO63qHdVDLzbIeJVvYLj6SZFmMsQRUTUqhTq9uQ6ag725YWhSZeWB+K7+4JwpsMDD
         7v0PMw+BbecIHAETxj3EPlDxa/pDU+bh9sAYkPhuCFfvFZUgqBg2ZIed9HLcitE0ACYw
         YgpQ==
X-Forwarded-Encrypted: i=1; AKwUvByssU3RJMAD9vwZBDkOBvA2Tn9yHsmPyOpz7Xzn0bNIHZ3Q8EhGH+6bzgQZ1RSoznwqdv7fTXNo304=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAze/Ne+Uu1mooFjmE+vTVRZTqHRFjAS3Wf+bUjQnyhNZaidL9
	Ey2poovv2IbUTF2Lqa5FQo8KD6K4p7Zx78YaH/v59eFTQbSU38iv9BiR
X-Gm-Gg: AYBFou33qszaa7QtUyFkSgSgG3/zXhXYqKej3IdiD/r2mZk6TOZJCUeqwNhAqqWRa4q
	NYRtvr+OFGUTe44g6dBw2h3qQu2N3TvGplHZON4mI9UPe1dDri8B4HK3D/jfFj2JYUtq/z/kpfz
	AXRKfpmroZsYqCLItfyuzg9AEfEE+gzoC3w3K3bTKolA5RTZQMYAgLs01lnza/aC2Y+g+xnYpGt
	HCL2bCr5px6M7Nnlh4fCoj8ffeBQ3Eyf5Knm31/K1b1JVj1VNBNULYPzaa5A9pD/glcVmsbhHH7
	Bzy8ll2Qz5QqfsD2MshtnBPeK5hIDHUJlGZArhG4fbWtDrRp7vu+T17uu7dMpC+H/f5wL99oYvL
	ud4fiVsUZmMN/hULA1QKu1wpF8w/KpmLLKTcX/MHtx8xrCRxv5u2YVXyHWKofQour23hICU6+lO
	HvMP90LX6zQoP2cXIudkg6lfKys7B7HHY6HHnPcUz69p2AuV09GVwvo2aMlyT8U+ficL8RKJi1F
	AM25DoaHhfUTTh7eP0hqwig4xrRxyHFrVlMDDfJWbHa7IxlxKnT7XxIdYliH4y9gJ2ztRCSjg2h
	QiGLFRg8/jCC13IGtXjCy+Ao5fitKFL5NFX4Pm5GhYzFvNA5anx8L59MJLh3uNffAcu1Iu5J2BC
	P483iEN9ULbsTviPzzJ8gYpCqLVuVqBYkLrTCYzPU1ni0LTnQktzWgAp0HIwUJ/ENUrrZSVE73f
	DURL6m
X-Received: by 2002:a05:6000:458a:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48e1e7550e5mr2034223f8f.4.1792477774042;
        Mon, 19 Oct 2026 23:29:34 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8314b0sm3948944f8f.55.2026.10.19.23.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:29:33 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:29:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: wrmfwv@163.com, nuno.sa@analog.com, jic23@kernel.org, robh@kernel.org,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tenglong Guo <admin@micronull.cn>, Sashiko AI
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: adc: add documentation for
 adi,ad7816
Message-ID: <20261020082931.00001c99@gmail.com>
In-Reply-To: <5d43ce8c-18a8-44df-afa3-d0d1d7b771b1@kernel.org>
References: <20261018110015.39497-1-wrmfwv@163.com>
	<5d43ce8c-18a8-44df-afa3-d0d1d7b771b1@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 07:58:44 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 18/10/2026 13:00, wrmfwv@163.com wrote:
> > From: Tenglong Guo <admin@micronull.cn>
> > 
> > Add a YAML binding document for the AD7816 family of ADCs.
> > This fixes the checkpatch.pl warning about un-documented
> > DT compatible strings in the staging driver.
> > 
> > Reviewed-by: Sashiko AI <sashiko-bot@kernel.org>  
> 
> Drop, never happened.

The entire patch can be dropped as the AD7816 driver has been
removed [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=f22c353859f3719ffb1f2528eb5be8415f680aa6

-- 
Kind regards,
Joshua Crofts
