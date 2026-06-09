Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B4400DFC
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005220; cv=none; b=dtRp9LNjCrsA1E1GvKpxilQARje2jQszl5b/yX+dMIjyFOig+N9cKHcHN/pyGOKpSB0wmryh5yPMB+Ht20EWHvNJMmuYJhGYPyuK2BcF9b+U2gBlfjZN+W65l2Y4DtLfYuvNUbDmQ6WLsPNIbFi544HxOs1Hag+FD5onAxod8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005220; c=relaxed/simple;
	bh=1q73HXxmLv+Z/5esi306UTJN6Xbe0kiLh1L8CCyZ3BY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgN8atf6BDZvNY4xecKbi+NORA6Ud/4kpAqkYli7shStV8CXDPXbcJr1jduQW6DZ871yOpVqNc+8JYR83JEOszthDsiRD29t8HqlA3UsTSYmoBQZB0XHHRzp36PfuiT/TvnMXhJu7+nak2Qe8OiYrjjlbL2Q5jcvxKYsJMNI3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyC2IbQM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyC2IbQM"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bef8b97655eso1013947466b.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005215; x=1781610015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BBwsJrPe4U8Zso/P0DDbySIpgby0iNkXrmQsF5vCebU=;
        b=ZyC2IbQMQ6d2O/ONHSvUmy3cm6hrzeu2VEE8R+L++dRYrVWtvFh1xUMVq6MBXkV0LE
         m992zGAwrL91EGGLE86Vr3z2ets9xUFdOG6X8aY16YtQPiA39yiaLudEyMXsG2zMaFxB
         IgzQBUBhF323XXyjaloNB+f6o8lWW2H99IRUUYszZ/kLUydlY7sgWIV9IRQFPgsqeqai
         yq8zU5S/bt73EfY7wJOUApWcVdaVXlIbPhnqf4IMzQLZJmf8d7HxqO6Mq5Rf8Bq0ewpH
         BSBaqQPOKHT1Y4CvyKtfgsK+G5Zb0lIxKoprogPHyKX0fXlQq/1poDMwfxC2m34bhVWf
         QGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005215; x=1781610015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBwsJrPe4U8Zso/P0DDbySIpgby0iNkXrmQsF5vCebU=;
        b=R/kFQvMoblNQAwvEiUuMYyyetgnnu8VGH1Yu5h9AK1OWyLZfAaDME9B4f/MPcihX1D
         2z5jDcJdeAnpuhbxX6xYLd3MkDiMGeo7asbNUfZDTrz+YtCSnkqOWoUgPd83evFogwjV
         g3xpwitl7VQBxpaBU+wcWodJciKx6JbBwXQfC1zZiKZB+wMQu1L2MQylEkK2E4ezFwaq
         vXzULb4K2xfKcWAFCkMYvfyYayfaCdPPJsP1pGOOSrMddz4CWeSbd5DKI8AulxlBV3ox
         EgFnmLpzWUqh9B3EBJ8A7PvAB9DcojDtCXdYlCaNf3gnV+uiwU7IEy5Zg3PGQqGDc1jX
         G43Q==
X-Forwarded-Encrypted: i=1; AFNElJ8QLua2fzYTVF+tBKle7udcXT2iA0Uuu/IvU6ZZzdHz4qCyORHjUAxqrsf3lOFjrsXNM7F2DS30AfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9h9hSqQL0mkYcrwgYKeQUpUWexag9oDIn4mV8yVfEtHOjlD2
	HBJOIa5s/fsYieE4jRg25MzN3QpgAAVzna2IY4ZevK8KsgyihZf4SkmnL7Dm9+11
X-Gm-Gg: Acq92OH4sIK5FvU63xYOUcTkDuIvY7OeRuMgqplgTAKVOI8aDRc/alkYqi//yzca0el
	jBeY9ti8fArkXTDVM1sb8jmhcAP7s6jwVnWSYloFTPC7Di3xT2Fe800TQMFYTCV3PjUTFWd7Zf+
	/0wNIvRC8FeeXeZTP7ch2tno3ZMkcXbp/hdsvughIo3N9/r/shBhh8mCCMPElnHOgB9uGbokw4G
	o1DevzX5rkW/Baaxlb0Hz4MXKnUEyP7u7yWBOJt9NICDSsRacqLr5rQAQE7U/Mw0dyOcuLApyKx
	v4VLUyucmAeWoEXEp7xayr9UdohlJYPz9WaYkpdEzeLJ//+AHYSCnM3wWzJQAntDBGUDiBCLcPT
	TNoGNLAKy8HZsG0SCGzGpNPkcgRCcL7YbQEJhF+HMH7a/Ari7deNju985S5PGVkYs8rDCv/d3mD
	9XkieABiwaWinOXXUgBPumlt2PWxygQccxt88z5dx1ZeRLCOv4JlIJLqIHYkagqhDoiOMzF1ad8
	S/CHC4LBQWcQUbNv7qjPV1UyAGz36p157aLpyCSOiUIpSurow==
X-Received: by 2002:a17:907:7212:b0:bec:1632:ece8 with SMTP id a640c23a62f3a-bf3a840d953mr913763766b.15.1781005214911;
        Tue, 09 Jun 2026 04:40:14 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051cfsm1032495566b.38.2026.06.09.04.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:40:13 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 9 Jun 2026 12:40:08 +0100
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <eduvmlupbcxlskscx6xphd7ipbwug3kqxjqtcewk6n6f2eqzo4@2avqjjrdem2v>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-2-70b423f5c76d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-ad5686-new-features-v2-2-70b423f5c76d@analog.com>

On 09/06/26 10:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Adding `vdd-supply`, `vlogic-supply`, and unconditionally requiring `vref-supply` breaks backward compatibility for existing device trees.
> - [Medium] Making `vlogic-supply` unconditionally required forces device trees to document a non-existent hardware connection for single-channel devices.
> --
> 
> commit 8357cd3efa5f819678f24f0cbf0a39208f4078bc
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Subject: dt-bindings: iio: dac: ad5696: rework on power supplies
> 
> This commit reworks the power supply bindings for the ad5696 DAC series. It
> adds vdd-supply, vlogic-supply, and vref-supply, deprecates vcc-supply, and
> updates the required properties.
> 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > index 2dcc049f30e91..e5fbaec4adf71 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> 
> [ ... ]
> 
> > @@ -55,8 +65,21 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > +  - vdd-supply
> > +  - vlogic-supply
> 
> [Severity: High]
> Does adding vdd-supply and vlogic-supply to the global required list break
> backward compatibility for existing device trees? Older device trees that
> omitted these will now fail dtbs_check.

Yes, for correctness, it breaks the dtbs_check. In the driver side
we would rely on the dummy/stub regulator in case those are not declared.

> [Severity: Medium]
> Does making vlogic-supply unconditionally required force device trees to
> document a non-existent hardware connection? Single-channel devices in this
> family (such as adi,ad5693, adi,ad5693r, and adi,ad5311r) physically do not
> have a dedicated VLOGIC pin.

VLOGIC does exist for those parts. However, as mentioned before, for some
tiny packages it is internally connected to VDD:

- 10-Lead MSOP package for AD5693R/AD5691R exposes the VLOGIC pin
- 8-Lead LFCSP package for AD5693R/AD5692R/AD5691R/AD5693 does NOT expose the VLOGIC pin

I think we agreed to make it required and user can just repeat the vdd-supply
value or not have it at all. Driver would rely on the dummy/stub regulator.
 
> >  
> >  allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            anyOf:
> > +              - const: adi,ad5693
> > +              - const: adi,ad5694
> > +              - const: adi,ad5696
> > +    then:
> > +      required:
> > +        - vref-supply
> 
> [Severity: High]
> Does unconditionally requiring vref-supply break older device trees that
> correctly utilized the formerly valid vcc-supply?
> 
> To preserve DT ABI compatibility, should the schema allow either vcc-supply or
> vref-supply to satisfy the reference voltage requirement?

Same here. For correctness, it breaks DT ABI.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com?part=2

-- 
Kind regards,

Rodrigo Alencar
