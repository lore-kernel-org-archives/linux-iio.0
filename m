Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F53282F06
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511750; cv=none; b=LRFlALelxC65h8+UcM6p1Rgdqpte23PPg3oUcqyEorXhAB0QtGRsqNa0Dc0VtC4uw5YxKaBw58i0RR/FZ7l1/Tokqdx2bn5unX5lav8dJzE6MAPctb/Cu6BA9UeF7MtD+u8dLnEL0mjLbEnK17rihrSGezEllsNCHfRO0RJ+YwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511750; c=relaxed/simple;
	bh=23abfp/kQLWOThSLbZNmpJ7myKHG6217mw5s0gzaDUc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxjROryicikLo6FsMQLs/uo7p1ccl3iuOl+5kFVuv4wjeDmD48R9KLOXY2S0aUbfxm2tSNMT3wWxE4SzzawRds1z+dB62Y+CNJ4ApnN275pY3156TWTpYFKGsgvtIDZzOTic89HmhVZROGvar77SUUQSSktWL7fJeKUMgvO7WVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS/Q7Au1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS/Q7Au1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so43915125e9.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511747; x=1779116547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCmbe1kO5+YvroNi7fjha0Os5YK4UGBrRWar9TXwCx8=;
        b=TS/Q7Au1hDn/SijSFcLQD1eMNbgJnpADC4DgYXiM73exrQTqz3tJl3Z+KZdpC9MSkD
         oNS41MkFej2QfdN4f2nLhoPEgWzuEEENhB/NgGhkQSZvR/Z113Y8OP63mh0z5ly0W9Po
         7Pw7PYav2XTqlyn4nYxvoGEpBL0TxeU7+uYxvRvgAKFW6KcTaOoDU8XTm+WoyIOJLreW
         B1reVBU4yuYqH6Xpk7vINMMYgUzIMaXas//hnDfBqx2QSv5z3TpIeTIWrVe3kh559w8+
         OCCx5ESUDgRL52eZSm15V97JvFjI4OaUkt0RlmCHASYXDj64qvxWtuyHMDAEC4Bw4Qyf
         zO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511747; x=1779116547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCmbe1kO5+YvroNi7fjha0Os5YK4UGBrRWar9TXwCx8=;
        b=fJUE+7MCrb4PDXKQfSPMl+mFfDNhHd6U9zQUABS7nRwWlspHxv3AfAkD6FnyjN9DK9
         EJX/JO8qLTOrg+yRkIRPUq7hVc4M/h4eNeETTc5WfnTmkWsZjGb3XCspM1PzaPhH08uT
         lwABjr3r9ulMU1KVEsdPS4KULC/x1ngijmMTk4Ff9YAxokOSm1W26J1bLDouQQq3ZNwj
         MQ3RhNC/E3mYOxSD4BEIJ820gmrGyKMNcVx8yF736AnngUaLuELwwhpRM//VHDdyujwc
         fqRrOlKscNqYBZb8/96ktUE13pJsRG36MwuGZup/2Sy2LJ+pJAg7i3AO2+TF+L7oE4Jz
         yZKw==
X-Forwarded-Encrypted: i=1; AFNElJ+kuO7wpOzsaZdjalELCCNhqxnOA1rzXybtzpXp7pWY3l5QOHVmDz4IqsQvjJ7ag0zDt2PyohtU2/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4p//wEUq8Zly0uUIG/jEXLiO8trV+EoEvVYjn2wfu9VQwcLU
	XRHuYRYV1Ipcc+zC59umpcSZ7nG4AnKfhgX2GLBDiRfBCVELF2960gH86wKsX4LF
X-Gm-Gg: Acq92OGg5VAZQcSETWV5GAHBDkWtXYgbb+6KKzrkpa8Uf4mdHdKyHiE2bypZ/anjvtH
	3GrYXUGMsiZhJu21fJvlY8GAmQZUXq2P0QjLu0/FpcRJEZ2j9MeKuBc3S9fEMntqeK4i8YjeDSr
	LCNnnY+3DJc4GzXEsfqmfnSzL2PiXfFQuoGwgJbgp56HdU5vKpZasvArh9zIIL9yXrwhxO2eXiO
	xssY9RrmLOIQCNPtYJTcWeVYahKYWFkp4TOigiu0GFRn2NU/+03Ms16C6LQspd04t2EARbAPF1+
	4X68ajGTgqpx4IiMp692iL2E73XC9SLp+VNMGcxUuZ9ciLpL25WsF5fbLtpCJmAlbgAc02DcwOC
	l7tURMJkJxofxjzOuzCaNM0OQr+W2MRnAQGG+8nFawZx1FN1E5LESQ9fl8izCOO4B7p7Sv7kGw8
	VPxT0et2jG6x3dzxz5gEjhszVcBWuUSXbQ4KP6X29zEpXaEIFTYen8m3WL6khZWpaLHibX6K4h1
	k5XJfKJvHevy32BmAr0KqXjhb0lbg1NosX3jOX1Q0PJ1GJgHCsEUcgdAEuWj6s2jwetw50=
X-Received: by 2002:a05:600c:c096:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48e51f50982mr304018185e9.24.1778511746893;
        Mon, 11 May 2026 08:02:26 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db189d3sm65376065e9.32.2026.05.11.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:02:26 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 11 May 2026 16:02:20 +0100
To: David Lechner <dlechner@baylibre.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
Message-ID: <uphcx5zr4lmukuom75g66hp4agurty7yq6mo6ri6otrsscqfek@tn3u5jjszaoy>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
 <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
 <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
 <18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>

On 26/05/11 09:46AM, David Lechner wrote:
> On 5/10/26 4:30 AM, Rodrigo Alencar wrote:
> > On 26/05/09 06:42PM, David Lechner wrote:
> >> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> >>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>
> >>> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> >>> DDS modes, attributes and ABI usage examples.
> > 
> > ...
> > 
> >>> +       must be a power of 2.
> >>> +
> >>> +   * - ``frequency_offset``
> >>> +     - Hz
> >>> +     - Base FTW to which scaled parallel data is added. Range :math:`[0, f_{SYSCLK}/2)`.
> >>> +
> >>> +   * - ``phase_offset``
> >>> +     - rad
> >>> +     - Base phase for polar modulation. Lower 8 bits of POW register.
> >>> +       Range :math:`[0, 2\pi/256)`.
> >>> +
> >>> +   * - ``scale_offset``
> >>> +     - fractional
> >>> +     - Base amplitude for polar modulation. Lower 6 bits of ASF register.
> >>> +       Range :math:`[0, 1/256)`.
> >>> +
> >>
> >> I guess there was some discussion on these attributes. I see some of these in the
> >> ad9832 driver in staging, but I'm guessing they are new ABI. It isn't clear to
> >> me from the documentation here what they actually do though. I guess they are
> >> just basic transformations on the input signal?
> > 
> > Not sure how the ABI is not clear:
> > 
> > 	For a channel that allows amplitude control through buffers, this
> > 	represents the value for a base amplitude scale. The actual output
> > 	amplitude scale is a result with the sum of this value.
> > 
> > So yes, it is a basic transformation.
> 
> I didn't have time to read the ABI docs yet. For scale_offset though,
> how is that different from the existing offset attribute?

I suppose that existing offset ABI is applied to (raw * scale), mostly for
voltage channels, here the scale_offset is an offset to the scale itself.
 
> > 
> >>
> >> And a practical note, they should be "frequencyscale". I don't like that it is
> >> harder to read, but it is easier for a machine to parse.
> > 
> > Parsers like the ones in libiio is not having problems with that.
> > 
> >>> +Usage examples
> >>> +^^^^^^^^^^^^^^
> >>> +
> >>> +Set parallel port frequency modulation with a scale of 16 and a 50 MHz
> >>> +offset:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  echo 16 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_scale
> >>> +  echo 50000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_offset
> >>> +
> >>> +Digital ramp generator (DRG)
> >>> +----------------------------
> >>> +
> >>> +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> >>> +hardware. It is controlled through three channels: a parent control channel
> >>> +(``digital_ramp_generator``) and two child ramp channels
> >>> +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> >>> +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_roc``
> >>> +sets the destination to frequency.
> >>
> >> Would it be better to say that the destination is set when the the
> >> value is non-zero? Otherwise, how would one change the destination
> >> once set?
> > 
> > Destination is only one, so you just need to write phase or phase_roc, if you want
> > to target phase then. Does that not sound intuitive?
> 
> I was thinking about if you needed to change the configuration.
> If you set it to phase, then want to change it to frequency, how
> could you do that if 0 is a valid value for phase?
> 
> Also how could you know which is selected by reading back the
> values if 0 is a valid value?

This is where Jonathan raised some concerns, so it is a good oportunity for you
to provide your inputs! Right now, I am returning -EBUSY on read of an attribute
where its destination is not selected. As pointed out, the destination selection
is happening when writting to the attribute. In the previous patch, Jonathan
suggested frequency_active, phase_active and scale_active to track mode priority,
and It could be leveraged here for DRG destination selection. I havent gone for
that because I was not willing to add that to all the channels given that it is
mostly used for debugging, so I added frequency_source, phase_source and
amplitude_source to debugfs instead.

Destination selection for RAM mode is firmware based at this point.
Destination selection for Parallel mode is still not clear... could use
those *_active attributes or separate channels.

> > 
> > Zero is a valid value to be written.
> > 
> >>

-- 
Kind regards,

Rodrigo Alencar
