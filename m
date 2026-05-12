Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B23A8384
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598494; cv=pass; b=bo7QwBcurk/RlXNkJzHF1YVuM+nRAXIoKfOjlDUdTlN9iXObc7H+mYAOFp5rsTQkgFPQZ9i6bOSDMc30v9Zsl7W7aLx4AvZI1C4ytvGOdjSDVNljgQQjFsfYFRtCQaCLiHdLOPAY8bOVYb7rJtTuf1J+ld/KG7p4y+8mJSO8eDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598494; c=relaxed/simple;
	bh=dJmgR/cmFJ/vJVatc/G4WUlFmUmnAqQgzM30BI2FiMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGR0f9saojTgs3omJK3j8ohlTRytD+GHyU2i4RsimHsJD9LEHLIuBgCoOwIHckNxyECSwDr0VCqsP7RCXFSMiViGAwMmH/3BbSNM7ISujs30apfQ2tfFQiaf354yqVc277G8ompn6fDyxxUbIukaTVlf48JVx5qJCM/F/POojWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7VpfyL+; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7VpfyL+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3369001f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778598491; cv=none;
        d=google.com; s=arc-20240605;
        b=SHchbIWABcgJOYqx1Le80cjNbWrYmNAEIqXs/gxwRCyPKP5QfX6uwuHFUHZWtFHuD9
         yjds2EmvBjbLGY25geXlXgEXB8HT20RPDaaxx8U1I99k+i/R6UYbGz+R7jMbRkQD7jz9
         go3UuIys+Q1rGz+hV/kpPcZDcmuprcNyVClxJqAANSHYI0fRS26cC2yjdwJzKocaCenV
         0SwZMKHtBfDukrnQJEy6NRjx5n5uaFEx521vgY7fUWSh19734qgELE+16LV5aFBFRFxy
         SuCMiQPWGQUv5rW0xQxNiPy6pdVJK0aeEU7C0onuw8yfGyw1bRyZFiSD1/BRqSBMkwrM
         ppkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dJmgR/cmFJ/vJVatc/G4WUlFmUmnAqQgzM30BI2FiMQ=;
        fh=MudhFJWdQ/nNUvdyQTUj6q4AVHsgFRZqW9yxkjehQc8=;
        b=XRg9iseWnPDn6E1v5LZhX8lqkCTtdcKQlydzmrxuHramoL+03ueupFd6YffI9nVudR
         P/PzVrSpiauCbWgVWPUDQPflHw6+av0yQjarPFxq8XP5aqPwA6ZHJe5H82yXXOevodps
         cyDXv1io3w1xY6KDPIqvhCohcUITu5VwmgMrVCOgpUqcUwLuTGalDmXnmIxB69nBEHnx
         aS8WwYJPZSiDzR6+13h3X0qzEY7Gel0al7xYCLV5VRi3IG/DjP7uiLh3AE/iZG1LIO8+
         RFSW16nqY3pHS59+x9HZ5PLSiNW9WAb8sQVtHngZOg2lKA2+RJdaT/mr5I3KSnz8jHG/
         sMIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778598491; x=1779203291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJmgR/cmFJ/vJVatc/G4WUlFmUmnAqQgzM30BI2FiMQ=;
        b=b7VpfyL+IJiKRx7lutaKn+qTc/6he0JgN4uEwcHFKuyeE6F0BK1fbwcsF/EE7FeJWR
         FK4RqsySWSLsufZvApoP9ICsVoPc9vjJ8A87WtMEh+TGREyUm0aThZOQfhniyWpzbcQf
         lg49zSSuipPEVORxhZkdVRdJlH4KRhTDpd+kyZhBu3pPns2KuIY1AIbfkV0Z3WHKeouC
         MmR8G9WUFX/Pr342h6hfH8BABEb4eQpLdDpb/5f87RsFzKyjg5Vjs6/t+iJG3+sdqVXR
         +D0a6JOkKmAsWFXdC5e78mrmOStEi8w6s2t3Flg9SGDb0jgpRrH0JtnRXhbtL8fhZJf8
         BWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598491; x=1779203291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJmgR/cmFJ/vJVatc/G4WUlFmUmnAqQgzM30BI2FiMQ=;
        b=FZzUovMfI8zxI5QzYSyDyVjvpyXn2oynS9bzYvU9xLzwcBOQuH2fSmWOqXcDqBsE22
         T3rOkBPDWmf1NNzUEAEwlj9HBqLCcsVzcOvgf/q2178RFighQ65iRNUA5RijP9vbmU6g
         Iohu7gnWjrMM7gHf4TCW1lovX8bsKErroNsaAA6RhwZDvkyRcBjdXQfJAueSCybspova
         vgDbr2Gkv2wumct4vuFkrnyTOMpXCurvvDXa1DCtfpLREpmiRXXxLjBK8cqsWmH+OPDe
         +7rAd+XcfRHi7jlJ++5Nx5A4jykbmZBKdbT5eO0jbd8kBMXiRDEB36uNl0pmaxuq/4aF
         ZJvw==
X-Forwarded-Encrypted: i=1; AFNElJ/T/zb1x9noqibI4DZaWudFw3B2vrOyzptXmCcik6EFVsDA19o+37Kjox0V5Oc58cqeohk1Rschv14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8MEKbFj89wzLvskONV582NM5693kHyEiJIC74Oj5S37k7WEy
	GSTuS/QtFCS57x6NFVVYzwWEBOnsJElm9HCw23WwMXyfivw7Fch+tly0luspCHHCmA6QFVUhOyF
	sIck1H9HpQDX2vpHY7uqHiarsKaKjO1kabkit
X-Gm-Gg: Acq92OFF/P3XlnIpgF4M6PE5OqDildON/9MM2ECtQzoUgZoZLNxv+sIaYRkV+Cj1sDw
	p541JeNqjYR1Fv22dG7NkJwWEqQ+gDW3BTuzXpVU1uUod5wWhJTHVyJkwz49GmD2NbbjR2mn3vR
	xUhvbe8UklIHVXsWGJtfg58SCcF3ejjvjdkZ83PfuqlOVq5bK3gYpG3Y+dCKlLkGZ5IoYYATd3z
	ncjbaMWf1z9yzBUZs1TKNsGj15ChJEx9QyGik4eckMww5eGiDbOwUY7o11XZ0T7abd0m/MEjSla
	+7U71peO9+8ZkpN6nEYV7BGQv6g5AQ/be3R+6/82RCRY1zlaj+wxAiZJtXjPwfXH12NuOtvEi1x
	RFpTFjKH7XmhPbWQjt2ANVpfvEf+AEIBgw7BEYg7HJO2UkIEGdS3puuGwApfHlslmu5yZJnbMPy
	qb2C9WdA==
X-Received: by 2002:a05:6000:186b:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-4568c19b2a6mr21401150f8f.21.1778598490991; Tue, 12 May 2026
 08:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
 <20260511-magnetometer-fixes-post-pickup-v7-5-9d910faa28b6@gmail.com> <20260512160428.51c1e1f4@jic23-huawei>
In-Reply-To: <20260512160428.51c1e1f4@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 17:08:00 +0200
X-Gm-Features: AVHnY4K0o-H9R6e_uhbdbGaiwsdQ04f_N1zDhz2-IDwQUK3chTQ_0dN9ZYf_rSc
Message-ID: <CALoEA-ySYFtW0-0KOR=o7M4UHTFR=BHqs_oZwy0N7gLbQVH7GQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] iio: magnetometer: ak8975: unify messages with
 help of dev_err_probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 at 17:04, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 11 May 2026 13:26:14 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> =
wrote:
>
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Unify error messages that might appear during probe phase by
> > switching to use dev_err_probe().
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> At this point things have become non trivial enough that I won't pick up
> any more today and will wait for a reorder with any fixes etc.

Fine by me, thanks for picking up a partial set. Will send a follow up soon=
.

--=20
Kind regards

CJD
