Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDC3769EC;
	Mon,  1 Jun 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328331; cv=none; b=Y1W3F9MFe5faRkHceaDxmznl59qqklrhg30CFGRBsunZ299U65idqBkWJxNhGPXRdxgruQV5UAzEpjaBax0J9bCcNLbDuIl+lmkOUD1Eb/2vJuZdy95kl0OaX3hKxg9piZ+0CkqKZsNKEOvPY97Krfh3TcQe6Ot/w0FHa4eH64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328331; c=relaxed/simple;
	bh=cjJM0AuKHJ7/fpPssl+IziQIpYjII5HFp1+MsmIJB1M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tNhsDwYIh4DDVSXkk3LAeoPytf7dby7bcS/Rjf+bpQXVHJY4Fe30j4wcek016mwiTyM5//lXW2PjQXFlMGgvvJc3Wrte+SIE03Ra37y3s5ah2JRxGPsb4bH+HXTP2m+TstrklqnETLGIcbmS8BYtfRjT0+m8qNyZbhSE0+aGYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=myff+Cjs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="myff+Cjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780328327; x=1780933127; i=markus.elfring@web.de;
	bh=5fn4qRgiaMOK6oc6hVFC8K8Q71DLwprMsHVNmV7Ulls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=myff+CjsjRJ5r8/2vg0Mf9GETAguzDf1xeCkmfnwtJPSnxawvzImvKUlmeyVjh7p
	 mcaKX330rx4aEWHzPKKbBGkYiA/dNLQ/N0d5n/ia92ZySusXCz7BkV+jEOEU9M1pX
	 IXi7jE/FVhNJx2X4dxdGc5lHPfuWQxbRdzU0tnD4W0PW2NAqpbnaw5A2vSGxM1a3/
	 79SBo8iV13BpGtwDA89NsdS3TTOZ79Vs+66u3WW/08pQaVJQm06A0iNtIr9DUQDor
	 Sq0fZkV8TBzXZNMdU9InABLNQweoTq+WrKEMIpQEKVFXv5sOUKgUgtkRC59iLluwW
	 2h0BenNwJ9vzHysNhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1wRbkk1MmP-00C2am; Mon, 01
 Jun 2026 17:38:47 +0200
Message-ID: <e0a07428-9931-42d5-8b29-f92806ec39a9@web.de>
Date: Mon, 1 Jun 2026 17:38:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Tomasz Duszynski <tomasz.duszynski@octakon.com>
References: <20260531233828.60697-1-m32285159@gmail.com>
Subject: Re: [PATCH v6] iio: chemical: scd30: Replace manual locking with RAII
 locking
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260531233828.60697-1-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mq7spENSFHX16G20zWM+qNkDDeJxvyqVp3UvJ/Ck5Safgh0wWxl
 RxLjTKAUo/CJZtiL1X9l48tzWrHbq9cSqIxhRxcGWjmgqjuQpCvZeuCx8qm1tbZYlN7O4/5
 4PqoC6oyyUCy30BKiLhqIS+Zr97BtCciR7DXM8UlgHrjHqXjDxs8FXLo4CUdSgAlGMbFTUv
 c6R/259hcDrnQ9q2feHpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yYQoy0mBpNQ=;ja2F0M8hS8KzF1yjzzYjwcuFIiT
 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

> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
=E2=80=A6
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.

How does such an information fit to a known patch requirement?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.1-rc5#n81


=E2=80=A6
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -368,11 +368,13 @@ static ssize_t calibration_auto_enable_show(struct=
 device *dev, struct device_at
>  	int ret;
>  	u16 val;
> =20
> -	mutex_lock(&state->lock);
> -	ret =3D scd30_command_read(state, CMD_ASC, &val);
> -	mutex_unlock(&state->lock);
> +	guard(mutex)(&state->lock);
> =20
> -	return ret ?: sysfs_emit(buf, "%d\n", val);
=E2=80=A6

How do you think about to preserve lock scopes by using scoped_guard() cal=
ls?

Regards,
Markus
