Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610857;
	b=cjz0om3NhR2gQf0WCwnF4J7/KkA1M0pege23PzHL2fNmOWsqr84EHongCOWoSn3H4A0/
	 GI+j52FXco1sE/IYiXLcL3kwGW7GyXF33X35/lUlV2gBezFwfYVNinGpqXnbhfyqdojjT
	 P+jSP2xFw/Sl+q4076yLlvPgIj/vOU7+vNVx4Iop1XHYWq8Muxr8GVH0B0/T2g9M6AApD
	 EZ6QIaIAU47EDysoLGMpy4cfcOmk/m9AqnMSnb+yijHpazvV6Fm+tbVexK7177vwm4Uua
	 10/1IK0vcp4bOvkLaLEfk+Q/LInBOTTgoB/erFRYw3wWgVYYGN63l3aZHMkrbama9ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9l2X88+Cluso3aHhPPG2aCJ5eE8RQhXDwPSZjiqGEds=;
	b=3rNkGOoCAklvJCwA6W5SV95yEedxUUuMw1G+kxZCzZMkl444Y1UIheXFcIaFs6gXzeqA
	 AcApEDieAVSEJJF10/q79wZiVScWTOit3Tu0z4uG/Kun3+H12u1D1QoSf7+HnssfUIJfn
	 duUoGNMMAHZWtD0Mkzr3Crw97DI05gPtPc9xJERhS1Vor2+d5Vv0oX4td4HUISpQT96Rj
	 QqANph0JzLSMeeDkvP343dHXo+Y/QJc3Dfz+p/aGjvqiTHahE1nSKCu/a2NZemvJOHCXd
	 2MpIjIFL5DGgEH28K6ilC5wI2D4bix9FD8hw7Af0/P34AJAPr66DGs4AoBwDvmdiWqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0oM6kP4;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1275606A329
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1275606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0oM6kP4
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so4317442eec.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793610856; x=1794215656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9l2X88+Cluso3aHhPPG2aCJ5eE8RQhXDwPSZjiqGEds=;
        b=f0oM6kP46WR4dmdZu0WgAUymTn0f6gib7tq7NgaNKpL1x0Ew3T/uU7llBroJvV+Yqp
         y9gsrGBzR3LkTSLRZp46b8lxFfMlMOAKf/ikLXnN66MyNxKes3Ib9LG0MaFOEHmIqMLL
         jcIuhkf6+bP2mMn71EwG9UxoY8z8eFMvLsjKzZ7F/uUBGZAvqdc1tJn4wRXfGS8iuVf6
         FHz3yQ080CjY6zSiAJlgzJ31TMCBWKgmsOUOAQBC3DIaPjlpT21EKOQKJeeq4OV2ViCJ
         9dZmIBxc+L4u2wvrHmf0J/f7k0tquIUphnL0xZrN0tr5yNNRJM48bFmq6yvFjIBYQnqV
         M7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610856; x=1794215656;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9l2X88+Cluso3aHhPPG2aCJ5eE8RQhXDwPSZjiqGEds=;
        b=Li0ece9p++O6yet35YsXvDDJqXT9I6aoQW5S/nY4UP1B6PnzhDUcQUluvT2okRTpDp
         nCvW0OGKrFHUXI1fBNfDVFPSXHikZeatr/Uwl3hAquoUOWbfotR/Q6lHEiZQI87RMIMh
         9EvE0zlqSzcV/KOm9hMF+QZdp07QbeNwjUrgJVF0E0z61aTWO54eA+8W4I3wWHTEu6G7
         7GtvER9Aha893E75hGuaJVIY8IX7D82x61axrLkKy5/EfpeUn7f8Ok25KgQ70/TXXGyZ
         uaLS9GjYP6X36F10P5j4BkW6f8jjp5IahdaQPYxgRMO1cWTf8dxCpgHeQCys3oOKJaay
         XvGA==
X-Forwarded-Encrypted: i=1; AKwUvBzBeIaszIAQN4TSRked5NETUz9mShD8c4wgPUlQULlI96cAEHYKCiO6LZaa6achji+MuIpBm3Fh4UY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v+3L84X7IDAGP8994KyRWNYmKxxTSS2W9EjjFdyQiUlarIM7t
	wdulSToFsbAin9ieEbtMVmgXpaDjAAeFR4TYA985UqAYpoiqNYVXCsh1
X-Gm-Gg: AYBFou2HwOj+l7ElwlnmxWbxRxZATIQ+DnPFO200BqpuWf+IbAXi6HauIzxq4WOnQyW
	JHtDEMHomUINQh34tPG8NC6yW+4uqymjKq/wB01Vr3otSYPXaQnGrgPUmShiEta26NH7UmeWyJv
	1wr6r4fKDBc0uuvkk68s73ddeQvKlOhzPDuv0hk185TbfufuevKZx4vmrf3qX31JvCTZljMJOKt
	wyY22zkBsiVEHRvLk95BB78+Bp+ZcXTzxfGXnBrZkyfaN1bSFyj/ytbz8htQJ1s7dBVIQUFt+Pj
	jYPUg81jxXm6nhkwEGbkiwHInEiRfXyIMNNDZo3vZU6+OjvWhcVmPnSpOo7evp//pTA1FiX1Eqj
	Gz3fGI+XJUCGVFH5gA8UHz2ioT2PNAmoAgFnhpmzQotjTGtvejFUR3Cmlfsdo+pxCu7kdy2aRet
	Y4jhTvwCYOpn6KzGj8pludHnpPDEn8iyd3uQ8o56JrXmu8u9di0v/SsdoaATbFWveOL8E2CekJ/
	iaF0zzts4dS6WOlTEZkj0xL3jAp4NjgWq0d+zjUzYkzqWkiODjsauT7hoTBgRK/7t+t5FpoDOuU
	yMdnI/lCp27IPdRa6Aa3mKMvmM7g4b3nAB9IyYRhlYUg7ulCESVoWOdZIWrSkBumtpk4gay8nX8
	agoW4eIVDxgQ3YrGmVUrw/ihokUEv9fwDEJS0AF05bTHTE/A54rpgtwwmoYzR9hElu8uDMP/2BU
	76u1SY3916tsUNXt7WzCY002eQTsUHjPIZSKjZt7vijQ==
X-Received: by 2002:a05:7301:d198:b0:360:db68:3264 with SMTP id 5a478bee46e88-36a42340756mr15320792eec.6.1793610855684;
        Mon, 02 Nov 2026 01:14:15 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm41886949eec.25.2026.11.02.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:14:15 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Mon,  2 Nov 2026 14:44:08 +0530
Message-ID: <20261102091408.246416-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <108cf042-5f7f-4b1e-9656-3193744e8043@amd.com>
References: <20261023185652.195025-1-kapoorarnav43@gmail.com> <108cf042-5f7f-4b1e-9656-3193744e8043@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 02, 2026 at 12:41:59PM +0530, Sai Krishna Potthuri wrote:
> ams_init_module() already copies ams_pl_channels[0..9] as the 10 fixed
> channels. Inside ams_get_ext_chan(), since ext_chan = reg - 20, DT
> entries with reg = 20..29 map to the same entries and it create
> duplicates.
>
> DT binding requires update to allow 30..50 for external channels. This
> gives a maximum of 10 fixed + 21 external = 31 PL channels, matching
> ARRAY_SIZE(ams_pl_channels).
> Please let us know if you plan to include the binding change, otherwise,
> we can handle it separately.

Thanks for the review, you're right. Channels 20 to 29 are the fixed
ones in the binding's own table, so a node for any of them only adds a
duplicate, and that is also where the extra 10 channels in my overflow
came from.

I'll include the binding change. v3 will be a two-patch series: the
binding limited to channel@30..50 with your Suggested-by, and the driver
only accepting 30 to 50, keeping the capacity checks from v2 so a device
tree that repeats a reg value can't overflow the buffer either.

Thanks,
Arnav
