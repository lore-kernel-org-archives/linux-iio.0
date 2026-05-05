Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82370311942;
	Tue,  5 May 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967823; cv=none; b=JAwCbUou4MxcJVDRPB6hdjSYgFmQMpZ9/zYoRU2WjRpt+eCnhBN5mxA5e3cJJ0vi3ULmlDmb74b4gHq1CmiuxL3DLpnxcDmd2R/U4tZLJEKErdW9yIL+DYMpmm2hM/fMbfAmYb9EqNL1f9AxQG03zd45aj64hMxeIFW/NGQbCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967823; c=relaxed/simple;
	bh=dm+0PvYyqnY4UuK1hNp7jgdgw0oGOZobXuT17g/XNEk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MKbr2wTgvP/6AnBNAFc93sV0YT9cjZ1/YcZ2DMssu0xemi5TBjwr7JvDKP1xiL3qZ3Y0Fd40qg4eXQXcr0r/C9228oV1mN6egRBMpVOBYJFx5UGrFizmp21aUruIpHDlLwhFGwDv4ThqDDEWjJFU13xfE5cRr21B9TDtfbLCOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YMCkGIIE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YMCkGIIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777967813; x=1778572613; i=markus.elfring@web.de;
	bh=dm+0PvYyqnY4UuK1hNp7jgdgw0oGOZobXuT17g/XNEk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YMCkGIIEx4kTORdOO11UhUZqEKIg0090445o/ICDk32T6w2BNAV1T0e9pK4T9xgZ
	 cGRjDrW+0oIDeRPSh7AQivxPsboJO8OUDmRrUSTHuTxe/f0vuTs6/DTKsxNxc0VuE
	 iMJhWs4lte6ZKq+y7o8wUigDINCp1EVMaihMwN03CPxQo3spvfjpW9D08dYw8x/7i
	 21q17jFCmU7hz2O8ubmOR9vpVALw6inmAfkUMtGmqnXIA73Yokl9d3rkINnQ3OSZ+
	 1yxisS0dU/vcoKqnd8KiQK7ZTRjMHvOtd44dx/y9XeVBiQQr1AWr6z0SbnEvN/a6e
	 g/VxuCXQlhUcnYkTRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdHC-1w1YMr1jZc-00VCvv; Tue, 05
 May 2026 09:56:53 +0200
Message-ID: <0c1d14f1-3d48-413b-bad0-4e2dda60a412@web.de>
Date: Tue, 5 May 2026 09:56:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20260505005506.160891-1-m32285159@gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Use guard(mutex)() family over manual
 locking
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260505005506.160891-1-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S7rSjN6QULHF8CN5hix5cxIah6xOCHjtRm66DHudtFH6HoYMUPf
 C1hD06A/JpJGh4LPsutWDgFwcXn6KI0shilTfLMLiU50RqQ9Y0iJH3ZWLNrhxihN/LlIYFD
 ep4p3az4836CH8Fzu0eqzQWCP2O2FG7hECFfDxD7/x21MFpaEReOxPhMMM8/5mN+7+wGgsA
 hcixPeGMOV41yYZJiiJ/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:afa+VC8O6AY=;n6nXftODhxxT2vsPHlYHWp+hWKe
 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
 dgDzJ3UlAodURrQ==

=E2=80=A6
> Replace manual mutex_lock() and mutex_unlock() calls across the file
=E2=80=A6

I find the word =E2=80=9Cfamily=E2=80=9D inappropriate in the summary phra=
se.

Regards,
Markus
