Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2613A451F
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847549; cv=pass; b=o1m6ZgnBJv/jh6cbcObM+vwIn8BSICp4hsuvyD1eReMe+nRHLKBUHTqseaCEqXFVrdqjRmfoLOZobjSlwKpAEOGklY/aW8LVqLsOIQ2BR3LxD6ClA3PqAnxs/ul0IBvK7puF+dwnqWN3EgHsM2eNmXFo1jJo/8gkysKsvRJQb8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847549; c=relaxed/simple;
	bh=l+sfxOPWo2bPFL9VE0PjEz8c8seHDEjamNot0fi4WhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOcox4YPFjtNp6PICE4cIhCrEbY4MJNz17HPDssHNlHhUuyfZ4/mLK7Kql6wMQgkjjsv6wZbdoEZJufp9RcRCi69QohdX8jks6ET0dSwleTeJPx2ScoAIWc0EQkCmiUFQu0ccsOdnK7mARK4J6Foh4AV/u9Eg086wlhIXO2+wa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJLnf/gQ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJLnf/gQ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c6a2158d3so8381703d50.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 05:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778847547; cv=none;
        d=google.com; s=arc-20240605;
        b=KTtepM19nuzJlfoQWi9X+zgPpocwtvXiUZW89ijCc2WRfBpbxZg4V9g5BXABw2K0ic
         AR0aGoieG94KZbHtLVM0KO2ZVtPobYv8djv9Iwd3TeFpfCvrCdulzWGOMx+1+IdLPTXd
         7zDKzovlc9i0lzpflkD7OVwFPWsQu5EcILOGjVCCf6TxQa78kvon3H/90RyDMqesaQFZ
         YgVNnijigxuRpNXaJXxDdKrNQ4HuXbxrR78Jo86hW9YxDBD9r9rHUf/LHJBFwJuzAdRG
         E/j1OieU4KQmV7r+JhAqAfWcxfnVUedrbcl6A9vmXNeUJmfFotVXDegjfthXAVSU9Cbk
         jzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+sfxOPWo2bPFL9VE0PjEz8c8seHDEjamNot0fi4WhY=;
        fh=kjWPBNBmGoMPmUn2im2EBv3pmeocthy2/0djj71ccKI=;
        b=UP27JQlfe7+1pNc9wawKNt/bmDuuLVxGfiNAYz8VNCRGCmIu7Ql1xbgJ51w/EupJvr
         ObEmN/EZsnryVCuYFmSBMqKDYDP8//fkbFdkoJdR/13XhA3wQk4xmIhuZhurspdAvF8w
         aFLScQi+LLkRDbJKssKQpGg4y9qRFq2StFOv2LhbWLllXJJGrIINNFiFNlyQO3PCVmBy
         Es/xaJrbxY0vZYp7/9vRLhw7EIZIlg3BWtcHO7NhDzUtBFHold3mAjPU0jDS9S1mu75c
         H+HyXKKV1xYve5e6adu9FUG1USFmi3MMnHxn1MkEG245b9GocUEB5uu9fAQ23kvPLiHD
         pjIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847547; x=1779452347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+sfxOPWo2bPFL9VE0PjEz8c8seHDEjamNot0fi4WhY=;
        b=ZJLnf/gQA+uY7jXGaHvBKhnQ1Mf7pvN7HQcSoyUhQ0ycE+xJQpc3plxkYZNjzIiVF0
         UsBo/01Pj2hy5HprfheRHkwg0iLHEUfpx9QhUFnBQxCDAIHhyn4aJKipriKun3i8qJQz
         1uGgmKjnAY7nC6wPZPrnQVsm1s5EXyWDJEDuN085f/Guuf2FqHTNrEA6FZIjYRu74Vpa
         6YUFB7kcbaWYQuXnAylAbXfF1aZif5X0M8g2QiZlp7WXeHXNimAV4Z6Jqc/Yv/nphzcX
         PlTpY1bWMooJjWcjbal9D8leZF/OJv9rm/U/XNA8Np2+eHEK7ZxbDV0ExWZk39blq/VC
         bQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847547; x=1779452347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+sfxOPWo2bPFL9VE0PjEz8c8seHDEjamNot0fi4WhY=;
        b=nsN4mfQ1ceMoHkznBTKHmXYlyii3vid9fCKHcPBkEO2NlB1do7Xy+T4IVT5QvOXHoe
         FiTLFQXGMMTZ/OE7Um9PZt4ZHbblISZw+YjfKNrVT8No0yGDRKq7vWnUlnQPmLOdrlOR
         Z5aDW22rTFrmQKBYj8pIuarcsvaqUId5+3Rh4VIQqMLZU9FGRv/l1AaNFvWkGGZpxiMC
         tNASk5kH9x9c/CkHQX32PQsMH5m89gG2gJAkcbJQqzKTSHaP7djFzvAIRm5vjS8y60aM
         AOPlTBTGtkEk0W/9arcFjKvD/l62a9MFQ6rgBstiP4JyqnRLrb6n7nwW7zJJwLdRVRwo
         nOmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MHtQeCt2mwQjdjzOoykgqyNUMTDGVh1tVWilIjZY+/E24DUrV2z6mvzjrelcrkv4Jf2agHwSKtE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1p+AMkZmz+OC0lWa1K3FaxfCaeJU7XTESYahBi8LwGOxVJHPg
	+7/m0CmGo5k/vZtT8UyM6y1N9I7Hgw2mn5MLUfRsNQFY5QnUsmFyq85syuxKqmoMXl7yIx81oAr
	0qhRxBAWYDH2HiL62B2MwLfpBPlNqdm4=
X-Gm-Gg: Acq92OFywFXFoPK/1EvsSUMN+BLRtefFXLFM4CS0/sn8BhPm6kWiCEXNb6rgXsNrMKt
	KXUyKAv86WmNbHTWGc4LCavZZwo4oYzNSqEdx57vc6sgtMeREmtwZJNjNA948qW0JGz7f9NuYmG
	nFOtZPXpLITzwm8zhUC9Pto022VPURHt/GD8vHxmSEl6l2OT3B5UK16tJLVZDwb2sEXVN6MZxgL
	w2xgQm24+NC1XPcpneCuLvuBpaFdGS0bAOmWS/YyDRyc6bnUEhTeZdPhhppLNufag2Sh1ABRy/i
	GGyq
X-Received: by 2002:a05:690c:ed5:b0:7bd:4a12:f08b with SMTP id
 00721157ae682-7c959b9161dmr40400137b3.3.1778847546596; Fri, 15 May 2026
 05:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515011639.28570-1-m32285159@gmail.com> <20260515-peculiar-purple-bug-c96bea@quoll>
In-Reply-To: <20260515-peculiar-purple-bug-c96bea@quoll>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 15 May 2026 07:18:56 -0500
X-Gm-Features: AVHnY4K41amtZmEaK0t551qK137IzOLK4chNTTOZayOWnIdoxLUHq2a9uBFl_Jw
Message-ID: <CAKqfh0EBjb2OR+cSw2gU33+ROoKFS-tiPYMPYvA=kFT8y1Fi1w@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: chemical: sensirion,scd30: Update
 maintainers field
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 2:02=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, May 14, 2026 at 08:16:39PM -0500, Maxwell Doose wrote:
> > Tomasz Duszynski is no longer the maintainer of the SCD30 driver.
> > Replace his entry with mine.
> >
> > Link: https://lore.kernel.org/linux-iio/20260507172404.80435-1-m3228515=
9@gmail.com/
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>
> This was supposed to be part of that patch.
>

Yeah, sorry about that. I hadn't realized that he also had an entry here.

best regards,
max



> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof
>
