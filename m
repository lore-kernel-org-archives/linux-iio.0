Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942124;
	b=MJR1DgCaCCzOyzolwwL67UZTeoUF1dz+1MAP/nTtLNPu7TLERcp9IBx58lHgmO3fjcez
	 Ld5hAzSIbb8vJbvLOiNbpbp3jPKRauAJgQq6IOuUMJpx8neeXciEPK/lj45gmaChYna0Z
	 AjLtsyxo3iyKKoFviZRSfI5zvuTKpo4liulkVI2Ha29guM57UoS7kmz9Eba+j/S/rZ9CC
	 zFzcJMfpHRFexN0xMBUJ0EbI72kfJw2PnbulYpI2+rtpNR/b5qZUnm+U2jzRUmuUEJ6LX
	 0RxTKU+GOCRQmpCJ+7vuveuYqE4CdqnKNjqXFr9YFnTYN6aigEMaCBxT9kwFX2ouzFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4RYfNMG1eKpHA0KEjn+s6+L4SEDBs5GP7IGY9wLwXNc=;
	b=uHl0nPC2njTm7Ewq5cI5zCfhUp4RvsKBpvRMaro+COX1OI+oO6xssiIGB1j+On5cp0Yl
	 AJE0LxGx2v8pKKZmVelTSyFNH/SxUvw+Y+lMzKZyTWxfGpp2ThZbPAQrFRCp65FbMtZZg
	 DwFJQsR1g/QY5w+LvUwycLntTrSfKRh1QjX6DmQ1OXc2WXaKJ94pWfpS8SWgpJ+mXA0Nj
	 jVbfvdg/Wz0gV79sxNbofOlUcICaR6Z4Nw3qEhiJkUnYpxYwMUBBQaP3Cm7gkWh+syVey
	 3RmomMY1Fx9SoUw8ks9syykAepaTmrK4VORorahO79rzV2NPvqet738Zh2KgNKvWB6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zCEBpQme;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D3606A31C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 19:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zCEBpQme
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3704d30b84fso370942eec.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794942123; x=1795546923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RYfNMG1eKpHA0KEjn+s6+L4SEDBs5GP7IGY9wLwXNc=;
        b=zCEBpQmeKODCcUnjNt3SwTVc9vCY9g4p4A1QpJYIYztkjpn7a9GsEGU2qeQ6XA358B
         XFgrI/EVWTuJujdI4g39EkK0EuQSWLPGdYvdQMfYnCOpkFjqitTiwIFs//Mj2e3Hiza4
         VFF9hyrefKmjPZMCpbji5mSK5QmhieAyjgJS8KScpm8UZGtbti2tRQKtkCRxzgWzUknA
         5JmlR2olm7l4oqWaiMZxHXe5+sfnJDSMoRXKRhw+CwAP2QMaafvkTsvWRNeS/BGVAsYf
         vEfjHXqIYYEhLTWxx2jda9HfhBQx+MdYgzG3xKw7/lVkzRdnT1z5J3xHAY0ZTKkpmCY+
         z0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942123; x=1795546923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RYfNMG1eKpHA0KEjn+s6+L4SEDBs5GP7IGY9wLwXNc=;
        b=xde6B2TGtTWzP1K1ipB6HI4NKYoqLdXyh648TgWxeuQN3W/3X9fKNEH0dAT7qSIyJR
         Tq669c7lcnp17xpDnOklIETVl0Z6CWEscPlCgNrIHDLqh0zrtlgMO2+GT1i9sr6v4CXp
         0aNOCP3oJx7XEpyIIV+ArnxNWr8gDl6anvPbHkEep3MmsB0j6k5ScPB9evbCG35Xsitm
         xeC1Houy+KAWbAAiO06EehywxeU87fqb7KQaR6I43PJM6WPBJXIJRLarNO3bHGVKLNPP
         WqHiY+moTQSBgjIRZcf4TB+0b2W20a0nny01XtBTxcV89VOgOHCRWNL+R3MdzKA3Ib+a
         enVw==
X-Gm-Message-State: APuU4Z+pSMkRw5/q656+O8mCdvtsYfGpT/g+K0JQ1sgR/QSVO/F31YVo
	/vYbWZXsTxrAWA/7VJa2xmgsTh2SYg0m9MQ+Mb8GNN62c6rnCYR0cJp/
X-Gm-Gg: AZFdTZeBbAxAkt7zWwv6eyk9r3IKwi4+XbViAYfqX6lJqXcEAVLiy/fW1hDYHrMW55A
	Qi4EJYE1i6oKPua8T7rI+jmoGcZ0OTKaqYXlC7gwEgAd8fOsQN/PX1pD5+xYIcfyN6+ozgq+EwB
	cP2XAIa13fBusv3SQA6dXLCr4iFZbQtdqv8JUfK+8XXILz9aDEXWJOdDQA3QHbuiHWP8NlBxT+H
	WfReLTJAyLOO/hTX+Gz8pIDDCwuEVtJOf09qp1j5/kggtMqtuoV6cmyLDnOLDolDnoS7o2rTLDm
	A+VmkWQSxbse6nKW4Jc/a07EriYKwSl2viHH9I9SbqflzZLQyjRjQ2IxHg1jGCkfqJR6YlcNrRt
	TiX9S/ExkMMfjGWEi02lmqM6/DJB+7IO9Rz7PeSjEp4ZJGHAoF4mkEx++Bm/gNrktw36cTs8/3E
	vSj1lD0FVNdK9OjvYLUxACiF9VHmdKfV1bQr6SQqkC7OAt32/npkJRNbldQFSsq1YxFz3t7WW/g
	/rqMbab9dhmTnNZ6RFpNLXvu2E9aNFN4/MFL49XZmMg7m0Pw0o+YhJhQDq4nsKJ3jYdbF4eMl6a
	8pgGK9Qyz1BzfuKJr2YGFVMF9ms7WCfhZGuYZm4Yt4v94/UzDroN5brtvTbWu2DR1phDLxFB5Hx
	ugkxiVqfBMr4qt1INyu1LosRtOR8p9YpwwbsVs2OyEVgUVuHr8pRW+4DFVESYfCYtdaMOf2jgrh
	siJyuCjLx2QNwKwURE6ug/FXR0rISi4lxcyOCbND7/wg==
X-Received: by 2002:a05:7300:cd90:b0:36c:a154:db1d with SMTP id 5a478bee46e88-3827d8222b6mr545636eec.4.1794942122580;
        Tue, 17 Nov 2026 11:02:02 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm46300587eec.11.2026.11.17.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:02:02 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx9324: Convert GENMASK() to use static parameters
Date: Wed, 18 Nov 2026 00:31:55 +0530
Message-ID: <20261117190155.47641-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117143556.1759717-1-andriy.shevchenko@linux.intel.com>
References: <20261117143556.1759717-1-andriy.shevchenko@linux.intel.com>
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

On Tue, Nov 17, 2026 at 03:35:56PM +0100, Andy Shevchenko wrote:
> There is no need to use run-time calculated masks in the code. Besides,
> GENMASK() over non-static parameters might lead compiler to generate
> much worse code.

The new extraction and packing are equivalent to the old per-pin masks
for all register values and DT inputs (checked exhaustively), and the
patch applies cleanly on top of my pending sx93xx series.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
