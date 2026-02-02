Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC433A029
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027626; cv=none; b=O8JKdUoUKl+xEkq8S2fw+QgZriq00RyZ8twqTaw2G0x7YADUROiTiX8UrTLwJboy+cbfFXp82PLgzDindf/8Pq4oo6+ip99j2zAcaLeiY8AsGg38hW9eKbOlQvVDfWF6CTOCUYQ1704gVhzdGWpVRlEWIq3Q4HQDNJd6XiA7I8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027626; c=relaxed/simple;
	bh=+F2U5AwTE3tMEzcVdzHPpXEosLjcvkikS4HveVypDNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1b7bHYtbKYLUmcZtsQVgipSemHJw8TW2rGZW0XeuOLz8BcjWk2L0Qj7SYQcrmSpPebraSDg4jWeWBwe+rbCwyg7BfX244+0JkgQUkQuuQElW9oF7y2WlGyllwkzv9bavdbu8/HgvT1fo74jK9F7fG62IsyRLpwH6zm3k7TZScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnJvVb1b; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnJvVb1b"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e2cb21520so475535e87.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770027623; x=1770632423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+F2U5AwTE3tMEzcVdzHPpXEosLjcvkikS4HveVypDNM=;
        b=MnJvVb1bZ/U6ezSsvBz1aun1t9MArO70xu0PZEVdfWH12P+zXuHanldbbLQAZXeXt4
         /hSjqnAWnmlmdvRfmx3ivFEc7ngdeXCX8OQ15SMCBANqYH0+54VM/pFdnstyOpkMisWz
         VMfwIvWj5JI+Ybi0l8QzxihSZQpo5/+9n5QJ11/ADlnsVtHWQTSB4UKBbwag/MWsliW3
         ynWhSB9R959bmM2fxlIjfJgY7DezYTiFZ3eeT2R3YpO3WPMCBYykX8v4MmNwXAbr/ult
         ldwuS04fnSqw1Vqikr8j5m+KrCUZNym5FHhwjlysE7XluPOiT5gX9C3Vk3/2FkJNImka
         XEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027623; x=1770632423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F2U5AwTE3tMEzcVdzHPpXEosLjcvkikS4HveVypDNM=;
        b=HbjuiIfaE5D3Vk+ViuKtWUfBYwJxwVfiSXeZjpW7H8xTvLzNkeJdgIKzh477kakD99
         NtHBr3NI4CPvYvVteUls3e9Ef57U5AW8x/m61vXyytzqvjc42nO/Xkvrq0Jb7ncDb7/c
         7Tt8gPTxgi8O4P3YJmgFpcpMo0gHniYwPGpiOzIUMkT350Ja7EkIpOm3iWzd5sJx2/Nm
         yFxG49OPe2tdFVHQ3EZZZEXSHhJwCHAi1aF8SBJUJVtC3+iCp9khLmQFooFm1+uELmD2
         ybsbFGDA1KBz1215lTRqZmuDRVS8fcM2MBfhD7CmI3cQBrkJhJoFjCIluKbjzqeCTPrp
         j69A==
X-Forwarded-Encrypted: i=1; AJvYcCUtYGyYsLaAamiaH67aQQjsP8aqG3rXWV7fgI3pNP5srfkM70nkU2P7te5/KQcKMs71HhxuhELlEhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGKXaVS2bvLQtIL6fnrqD5MHAJNgaEZWongs6jfL+M6tX/WwK
	hjOVLDDcTss4DTFaODv1kOOMLY8LNdsJbRjPAkhYSK7LP0ogCoaWF7M5
X-Gm-Gg: AZuq6aLAKpAKuW9MWmIolR2OXS/f8h+4LRs+Sk8YkYnC+JThjE5VBYSByG/6y36Kr2O
	4177Jp+q1YFg7x9FfZx5XJkvZ3qA+CI2Q0HZqrxkr5/g2JHmIfoo+8+cnuneuaWetk0GKWeKMZ5
	HQv9NQxAs7q2UufyjSyr5zLq5GypspnxoCtS2CyV4hzjPNHFbyItVJAa0udNrdZ2Qi+N+xS1Gab
	DJXe9pGOoXTjRqMjDywImXMh+6mO0HmrOVgrWZcZwWbPbTHgQ13yBixfaLk6d90D8NwnXCECfza
	PlEvzhgB+qddSEuUZKysFIa9J1u8orIF5hLtkFdbYZwGDVCzZVR4QRjz6/OXwf7SI7sW4hrNtb6
	t76cCFBpdrbmgXVJdgItErd8+EuhmrVL8CdWMkn6X0zK1OqSPUTDiMLc+e99u26hJMDeY9ql/pF
	NseUv+Zi2L695gWy0m6b0=
X-Received: by 2002:a05:6512:2524:b0:59e:2b24:8e4f with SMTP id 2adb3069b0e04-59e2b248e7cmr655804e87.4.1770027622556;
        Mon, 02 Feb 2026 02:20:22 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfb1esm3441242e87.96.2026.02.02.02.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:20:22 -0800 (PST)
Message-ID: <f7fc6751152ea58d738f0faab9bfb86f2dce8f1b.camel@gmail.com>
Subject: Re: [RFC PATCH v1 0/9] iio: Expand IIO event interface for
 real-world unit handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 	linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
 nuno.sa@analog.com, 	andy@kernel.org
Date: Mon, 02 Feb 2026 10:21:04 +0000
In-Reply-To: <20260131184811.1e86ffa0@jic23-huawei>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
		<4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
		<2f9e7172885c5dd20be198f013283c6ec0513ef1.camel@gmail.com>
		<95b13260-0564-445d-bff7-b3b54fa15005@baylibre.com>
	 <20260131184811.1e86ffa0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-01-31 at 18:48 +0000, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 11:43:03 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 1/21/26 3:33 AM, Nuno S=C3=A1 wrote:
> > > On Sun, 2026-01-18 at 14:33 -0600, David Lechner wrote:=C2=A0=20
> > > > On 1/18/26 12:18 PM, Marcelo Schmitt wrote:=C2=A0=20
> > > > > This patch set adjusts and complements the IIO event ABI docs mak=
ing them
> > > > > coherent with the fact that not all threshold value attributes ha=
d a _raw/_input
> > > > > indicator set in their names. In addition that, the latter patche=
s on this
> > > > > series update the IIO event infrastructure to actually enable dri=
vers to provide
> > > > > _input threshold value attributes.=C2=A0=20
> > > > =C2=A0
> > >=20
> > > ...=20
> > > =C2=A0=20
> > > >=20
> > > > Just throwing out an idea here without thinking about it too much..=
.
> > > >=20
> > > > Instead of adding a new field/parameter for units, could we extend
> > > > enum iio_event_info to add IIO_EV_INFO_VALUE_RAW and IIO_EV_INFO_VA=
LUE_INPUT
> > > > (and same for HYSTERESIS). Really, the units only make sense for th=
ese
> > > > two info types anyway.
> > > > =C2=A0
> > >=20
> > > Makes sense to me.=C2=A0 Or we can just document that the old value i=
s _INPUT? Or just make
> > > it the same value in the enum.
> > >=20
> > > - Nuno S=C3=A1=C2=A0=20
> >=20
> > I don't think that works since IIO_EV_INFO_VALUE could be _RAW or _INPU=
T
> > depending on the driver. And another point was that this should also
> > control the _raw or _input in the attribute name, and we can't change t=
he
> > existing attribute names.
> >=20
>=20
> Fully agree with David here.=C2=A0 To fix this up we need new ABI, with
> the old ABI remaining in place (including for new drivers) where the
> raw or processed nature of event values is derived from whether they have
> _raw or _input (and hopefully not the horrible case of both!)
>=20
> The new drivers keeping this bit is the only place I might be flexible
> if it is a real problem.=C2=A0 I'd still strongly prefer devices to match
> the channel presentation for these but if there is a really tricky
> corner case for a particular part then 'maybe' we can relax it.=C2=A0 Ups=
hot
> is that it won't work with standard userspace code that is old.
>=20
> Not the first time we've had to add new ABI and keep the old
> (whilst telling people not to use it)
> The multiple buffers stuff is a good example.=20

Sure, I was not suggesting to destroy ABI. Just a suggestion for the enum :=
)

Yeah, I desperately need to find a proper multibuffer user for upstream. We
do have some issues there...

- Nuno S=C3=A1
