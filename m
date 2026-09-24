Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D924137B2;
	Thu, 24 Sep 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237442; cv=none; b=W863ph/f5Cz0ZP13hn+0x2v92okdLr4FJDJA8Z3ptM7tlSV1Q++EDTfIdDb43x4W6Oi2JNmNJNcrzNGofLjOhtT90Y+zActLLR5VpJIuX356RcQfV0umb04IeaFIRdVc3abX/YdjDijcZfHMLs3PMjpbfCFgCnPfJxmJ1J20rGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237442; c=relaxed/simple;
	bh=PnsyK0FYPZPtr4OrpgsSp5PfQ4TJvRrksTAxw/wVyCM=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=POtLtdPKw6LFzZv3paY0EqSNqbTVBYDSlEsp2DKMeFRaBQ4E3+sTII1Op/iYeH79oJN3L8+CG9CREEBHs4vrU3/SESgIq97Bgwd2nuqh6z2+WTEJdGzuC4Fj2TXqTmvBOqJB8LPRveKE05Q8f5mkNgXaqs21jhmLS7pT9WUbOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=nFk9gWnH; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="nFk9gWnH"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68O7sq2U007357-68O7sq2W007357
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 24 Sep 2026 10:54:52 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x9eI8-00EeVR-6x;
	Thu, 24 Sep 2026 10:54:52 +0300
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 10:54:51 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Sep 2026 10:54:51 +0300
Message-ID: <DLNDVEMHDO03.SU7O58W19UEL@utu.fi>
CC: Andreas Klinger <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: chemical: sgp40: Add secondary chip
 functionality
From: Jaakko Koivisto <jmatko@utu.fi>
To: Jonathan Cameron <jic23@kernel.org>, Jaakko Koivisto <jmatko@utu.fi>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260920185303.67b8e10c@jic23-hlaptop>
In-Reply-To: <20260920185303.67b8e10c@jic23-hlaptop>
X-ClientProxiedBy: ex19-07.utu.fi (130.232.247.47) To ex19-16.utu.fi
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
 bh=CkzGhpZYuOvyXl1R5UCpwCFY6XcNsxLyDHvZ38SE3MU=;
 b=nFk9gWnHR/LJp+GDysw6l/6NG6ExYlL4ELOS9BVIbTD1VPnIEUhXtMLyZOw29hgK7J1n5LdAxd5s
	Fj+6KAiqiJF2bsoTH1hcs4JBi7syIcu29r+N9kvX8/Kz6c+TlQioaW38Pa7zAzHbO7Qqs5EPkZbV
	/E5B3889dqqLFPEue9FSieeyAs52CxtCu/75qpyCcssjAn3gdABICjg1pEJuqg0y4+CFLkEqjUx/
	25LSp7VJD9WvpedToyrZTbbkT7q4OJD3I3PPHlEDDtJBdRj+FMbG2c83Ww6GG47E5sUizihdes/8
	1lPTSyHgkvjnWd0mLJ1eEyGWvQEiemtxhsZIIg==

On Sun Sep 20, 2026 at 8:53 PM EEST, Jonathan Cameron wrote:
> On Fri, 18 Sep 2026 16:40:16 +0300
> Jaakko Koivisto <jmatko@utu.fi> wrote:
> I'm not sure what 'secondary' means in the title. I'd just say
> what you are adding
> Add serial number readback, self-test and heater control
>
> Slightly long line but more useful than a vague title.

The idea was that measuring is the primary function of the sensor, and
all the other functions are secondary. Not as informative as I had
hoped. Thanks for the suggestion, will change it for v2.

>
>> Add functions for getting Sensirion SGP40 VOC sensor serial number,
>> running self-test, and turning the heating element off.
>>=20
>> Tested with adafruit SGP40 and waveshare SGP40 breakout boards using
>> Raspberry Pi 3 and Raspberry Pi 1.
>>=20
>> Jaakko Koivisto (3):
>>   iio: chemical: sgp40: Implement get_serial_number-command
>>   iio: chemical: sgp40: Implement execute_self_test-command
>>   iio: chemical: sgp40: Implement turn_heater_off-command
>>=20
>>  drivers/iio/chemical/sgp40.c | 159 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 157 insertions(+), 2 deletions(-)
>>=20


