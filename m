Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154626;
	b=WCFD91x/vkLVsOPOqW7vWDD8SPksCZ1gjr3Gr1X07eLYPuukHmaBrcG6MvkR89QCRIpm
	 UPbAChIzH2ztY9eaRbOj20IE+uP5KO1ISXHm9Iok4fy3IGRxLbArRhPpkIc32vJ6WfIMJ
	 6Z8tGUEuUdUvKN8XYL6wH1wkkBOxcPPtUUG+JthndRZd+TFzhUXisdihnJhSUEIjhe0GJ
	 5dtMU1Sr4krMRnCrNPiHOTY6hOTvUk1L7HIs6+uw9lXimURQy1SDmk60c3Hbt0shL8C2o
	 A3xjE8iXE5zPS4WHIRc7xkXMC6Szxn/3citZRCn8NydoW0rXlGR8jOL91MiPYVCuCvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H6njA8hThba7qi/jT4brciMNl8e/UmucJb9lemJ86+g=;
	b=vJ6QHQzCFlELshkhuq2BNQho9nD9Rhi48RKCFyrHm4byMLN6ewYSrdCjMl74H48pjy+w
	 ICdEkS6nnO0G8JTWjtXqryBIz0Hnq+kDbabLokdPpg0bgo8p5aJu5D6ZvlCxjZNw6Nnjx
	 VJZje/IRiXt5DPciz99Sf9nD82lPUCmcp2twJGOr6OJ8CMRL2Y8fw4d0+n+l4JFfSuPXu
	 fvysjXnwjgBYIreA/21U0EH2L7zLRTdNR1rA1NLNBLJqJnx9JdY4MEOJCrSHXUBcVCw9I
	 vC4K263APhz0D/bcvZpVtqLWw3+MwYR7X+F6FkgPxX1dx0rWz5OAKgiLUfXoEHSQ40A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z/FBcu0h";
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F75606A31A
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z/FBcu0h
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc365db987so275740137.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154624; x=1793759424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6njA8hThba7qi/jT4brciMNl8e/UmucJb9lemJ86+g=;
        b=Z/FBcu0hjKcS82+4EvqpgC7rUp3tcRi9xHWrzEFKKFZMlEP6VGPNTRRZS+eyjZAaPJ
         v95c4AuAnTD2Pn4KUoFrpZU1ckaS7AwDTAFi34N0a66y6w2RcDQJqzhMsheX75GmwVZG
         2/ueA94G7C2g4RGeTVJ4fCrhXOVAxOwaitmimXXi0h5XuUk82+r6QQwIfrpGqkJkfSKg
         lqhmWfOPP71lHiTvhP0ADYM67ltDOp7ERCid3VZXnav2mohlhSjNs2JSY4Io+LGTrfam
         83BLBpkNAIonrmSUd2cqnnvK9yQuBKJXqHxTHtpQkL/HExV/glAbTExcoR7R6qdFKyOg
         j9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154624; x=1793759424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H6njA8hThba7qi/jT4brciMNl8e/UmucJb9lemJ86+g=;
        b=uPr0Z2/Hjrq8Wxg1Suu71j564Nhn3/tWNMRyN7EFwaITq2fNBqxhUBDBdgIhLJgiv+
         9VZuIU6YfpLhKx8u+ye+MXWuNIgdzWjjkBTyZx2OiTaPP7n6VU3auswLrkBjsFF/YxNt
         NfyFsEbOH7d8uHodiQ1KRH0Ed+aFZOPsLD8ARGZ4339FhdqwIq2ut2L+0gx/0uuR4hsM
         aYCduqeexAsuQRszXy6BhiTbUXcSBsEamBCnEFPReZGpZZZJUv7uxqmvBytY1PhDaUj9
         42nXz+S8CphvvcLwMKsQ1nLS43YaaLf0ZfvQhHcnSFzw/NhJtkXVi07fICOtVOD1BjQi
         ECEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvYXMTb9oD5UneMMM83Gkgrm2c8FZPx+a5RT9ANOTrv3d618s23upenjm/YLseCdW8zJtWjkiL8sA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIyJ0T1Xos2anuAHXl1QScbZbJOumbzTaahBK2K1vNin3iVw2d
	3Dv1UDFFyhH5ebcJt/9Vy8+T9m1miAEKHx2411cekHW54ZjnvWw9p8JE
X-Gm-Gg: AYBFou2GjcyicVzK5tXClAtWupFlB2S+V8AShidV1pl921n+yWky5pMBO0NZRFcKWUC
	Z4CLyx6LfIs4BPi1xfpvlH2dQyU1ZIeQsvus6l0Sch+unDJp28lLUZ7RTlpOeXoLxE8riqq09hk
	R55SXUvA+y2TUVAOJTNGokSrcY2NQEZ/nYUrNMOe62Z7UHDh3yHyNdCjIPW72jHaxY9R569CvWb
	Yhr/4sYF7gSZFsGn9mtCylrgnNrf/wqICIHbRY1g66nlkEJ/xFKLBxkg8d5oDrZxvNVER/8uqbl
	KK+v4qUAJgXBjeiv/obguASDfanNaPuP8KLgOw+w9Cp+dUBLM8B8kylkNEoDDh5INDNzOHAYBPe
	8EVYA5oyXvhdGjXHGVoGFE8zNMPu6gYEgCfy0g7g+kiiN1w6DSufmC8WBEVu6aWeBFvcGkzc/78
	KdD1VZkFOgO+r/+8WmfL1EtUh2zoUlAXtlSDxgqR853OluD3bVr40fgaascZ+x1OTidBzOCyXbV
	l3FLN/p2RVK1+UwLU09RXT9mYJtQUAJDhijAFdXAVz8HjRv0WRdGDMqtx6u8P7HxlO3XLeDPzY7
	JSRY+kvb2XT+T+DIIUCxdpvfVK02vRuvLknqRtjj4avG4YUZrWg7
X-Received: by 2002:a05:6102:3fa8:b0:7cc:776:6c5c with SMTP id ada2fe7eead31-7d03a4b9a28mr541141137.7.1793154624534;
        Tue, 27 Oct 2026 19:30:24 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:4df:52dc:4559:394e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f5cebbbsm486020e0c.0.2026.10.27.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:30:23 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: adc: ti-ads1298: add ADS1299 support
Date: Tue, 27 Oct 2026 23:30:14 -0300
Message-ID: <20261028023015.31876-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <at5nycDs6ImZV8X5@ashevche-desk.local>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com> <20261024231335.280955-7-stephanbrrs8@gmail.com> <at5nycDs6ImZV8X5@ashevche-desk.local>
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

On Sun, Oct 25, 2026 at 10:34:17PM +0200, Andy Shevchenko wrote:
> Make this a list, see how other drivers (recently updated to support more HW)
> do it.

> Fix multi-line comment style, make the text of tristate in Kconfig, this one,
> and in the MODULE_DESCRIPTION() the same.

Will do both.

> > +	/* TI sells the 8-channel part as plain ADS1299 */
> > +	if (indio_dev->num_channels == ADS1298_MAX_CHANNELS)
> > +		indio_dev->name = "ads1299";
> > +	else
> > +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299-%u",
> > +						 indio_dev->num_channels);
>
> Why do we need this? Can't we derive it from IIO ABI?

To name the part, as the driver already does for the ADS129x: since
ti,ads1298 was the only compatible, it builds the name from the ID
("ads129%u%s", so ads1294, ads1296r, ...). The ADS1299-4 and -6 differ
from the ADS1299 only in channel count, so the name follows the same
rule. Userspace can count the channels, but "name" is documented as the
physical chip. If you prefer "ads1299" for all three, I'll do that.

> It's not used outside of the loop, make it local to that for-loop.

Will do.

Thanks,
Stephan
