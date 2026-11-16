Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821054;
	b=BgQupOzGjBrHNjPbw4W8ymsUxHRuvMKfw/DKmXWGH+Pv/QZUAZQhIb3OqCdl0gv9Q7oh
	 Y0pLsVUv6yyaUxDLeTiBiQqidDupinoo+PSU4KirlxxlMY5TVmqIBVofMUa/EIn9gIcCX
	 Y/0fXrkxP2U7ZV0Kj7py/Oi6/wU+jcrG0HRolvyuiJr9pRwXrHWyv7i1Z3eBrND4vYSWY
	 BjxPSn8rdLMewT1xhTMWdi5rDkYMccj6ZXtjFdJ6P0IbyXv1c6FXVGNivz/ZjRyzy5REp
	 TyTGezU9M8Anx/oYobWQGtqRvAq3XQUnMoRnZl6Z4QBCjh24XLJqBqmIzDjEVGn6OzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821054;
	h=DMARC-Filter:Received:Received:Received:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-ID:CC:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=8wobkCk6U4WcewhXYiKu2e+Z8/2mRL6oNYJhqRpXCm0=;
	b=gJmVyDCgYmwl2KdeEmSrqdq6SvP9odPfximc49sCqtMqOwKqi8eTTbprQj7uOOp+6xf1
	 J/N8+AVg9PWjelFDLVV1yWfywLFU4WDDArDpF8N779g6E5xfZhA2kmpmqzQnpwpc29nsc
	 5CN79mGp7035ZfVGsUFQpgq5mGXLW6v4LQhjtHGq43qITav2N1NxUoaHHLMXHNOIZVzuf
	 iDg4BtZma8MKfQd2bQxmfSfWzbG7Bie2Xy9FKNczAJOp/j12EF2/jXLgTDFAW1vbDJjs6
	 TSpzpviEZ6GmKIIngVkI+G3OnYoX4FImBmjZfRf2hLgFjohSrhUUcGf3a6qmKSd1s3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fNqdFX9b;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F7606A329;
	Mon, 16 Nov 2026 09:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C3F7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fNqdFX9b
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6AG9Nlr2007444-6AG9Nlr4007444
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 16 Nov 2026 11:23:47 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xSswF-0004aX-7T;
	Mon, 16 Nov 2026 11:23:47 +0200
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 11:23:46 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Nov 2026 11:23:46 +0200
Message-ID: <DMWIYCXE9DLV.3T2MJYLQRGIQN@utu.fi>
CC: Andreas Klinger <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iio: chemical: sgp40: Implement
 turn_heater_off-command
From: Jaakko Koivisto <jmatko@utu.fi>
To: Jonathan Cameron <jic23@kernel.org>, Jaakko Koivisto <jmatko@utu.fi>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261102091258.247402-1-jmatko@utu.fi>
 <20261102095602.333752-1-jmatko@utu.fi>
 <20261108010518.5d9c0016@jic23-hlaptop>
In-Reply-To: <20261108010518.5d9c0016@jic23-hlaptop>
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgCAQta
 WygDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:cc:subject:from:to:references;
 bh=8wobkCk6U4WcewhXYiKu2e+Z8/2mRL6oNYJhqRpXCm0=;
 b=fNqdFX9bmWGBvfRGPlXcpCY6l0uk9zM8WvnDISY49bTfidKIP1Rq0MVgoGOoUi0qUeWdj5xBXmX+
	6mBQuoD4PpSGb1HRQJpi9kMEasSHMV+TSPkcYz3Wz3DrRJyIOYh9zImTjNNMUl/vByh3GCFHEHcm
	CnPHyLe9Yzbjp3REvvKEIdoxpGiTx0dsJcz6bUZwaoky830pjItujbmKVTOnLXDsyAzdPTQT7/P+
	EaFNcR185mSj+axGZhB2cVcysGOPcb8qcbTaeNXLoqyF9EALForZuuFYwM25BM74+eKaEEWE2un/
	DjV1vUo2WOiCw6BF/Tdrx1oPJKrVgqWkDvaJmQ==

On Sun Nov 8, 2026 at 3:05 AM EET, Jonathan Cameron wrote:
> On Mon, 2 Nov 2026 11:56:02 +0200
> Jaakko Koivisto <jmatko@utu.fi> wrote:
>
>> Add functionality for turning the SGP40 sensor heating element
>> on or off manually. After turning the heater off, the sensor enters
>> idle mode. Track the state of the heater in the driver, as the device
>> does not expose current heater state via any register.
>>=20
>> Turning the heater off saves approx. 2.5 mA compared to regular
>> operation. The heating element is automatically turned back on
>> when measurement is performed.
> Hi Jaakko,
>
> Add something here on how long it takes to power up.  It
> isn't obvious so far that this should be just done via runtime
> pm and autosuspend.
>
> Normally the argument to have a manual turn off is that time
> is huge. Otherwise, why not runtime pm?
>

I'm currently unsure which would be the better way, runtime pm or
manual. There is another source in addition to the datasheet which says
that turning the sensor on 170 ms before measurement is acceptable
(https://github.com/Sensirion/gas-index-algorithm, Algorithm usage with
SGP40 in low power mode).
The datasheet values 60 seconds and 60 minutes warrant manual control,
but 170 ms would be workable with automatic pm.

From chemistry perspective the datasheet values refer to power-on from
completely cold sensor, lot's of adsorped water and need to heat for a
long time to reach steady state, while the 170 ms case is for periodic
measurement and the sensor does not have enough time to cool down and
adsorp more water between the measurements.

I'm gravitating towards manual control, since that does not alter current
behaviour, the proper heating times are based on how the sensor is used,
and the sensor power consumption is quite small so it's not horrible
having it on all the time.

>
> thanks,
>
> Jonathan


