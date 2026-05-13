Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57835218E91
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684910; cv=pass; b=n4yV94Ongz9fA0+3poUw55XlR/S1ASYi9QStFIDs+QeCg5GExEHy8tLALfuSXP6KNnR9v63flhds+3kNjbRSd9yrx74gN8c1VfsAF95hPSjiK4Kdz6/4F51Fk255yC37oYwVqs+MPxJK7/mWZBZtUgtmZvNUgfIJYrWMNyk7PdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684910; c=relaxed/simple;
	bh=A1XioEkQCxu7L7Wf/qeH/pwCt0V36L8KzrjydDFazJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niSmossfBOgCMnZYDcRwCt2kmKakK/wLHyWfYeag2VIb6cIqMRgUWxql6UGNB70CUC18vtvSJVJ6ZSKIm4gtRlTj1kEWbwCghrbdBEtII48JC3ArdaxgbVZ9yIk0/ycMGXzIaPLkR+IF4ACqmlVyaHPkpI9kCD3ij1CGgFIRCEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frfdm/DG; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frfdm/DG"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1329507c387so883733c88.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778684908; cv=none;
        d=google.com; s=arc-20240605;
        b=bIzSw0V2tpNCvPuu/bbaS4Yg3YHMEHDP2EnaJQ04L8QpYYyTqZWAlwRlElAeZ/S7TE
         4A1l7i2CDNCzlBSdRdlTLNfG3YVvoKqfmp/PyXa1IO7eD2sCu8UEaHSW0L5ZZsiqMSFO
         dK6xt490OK8Xzb1+bK92lBEhUXltubLnI9oxEU4llqS4d7afvltS+dN4xxuGFsHX0ms8
         isAuEd1p17eCaPVK0JY3gLPbwixlBdnaKU8g8XOTVP/L//B71BnTzn6RnNdJZrcn1B4Z
         KhyVoyPDl2d+MWVgiDwX7fHOHf0fYTJf81jNktCOQJ69FqyCGYAJXTse4X1NnkjxlYTU
         qDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gfdsVavF1ADNUkRaWbbhdb5o1A1seHzrAfprJOgGQ1c=;
        fh=PCofPnZnVCj44LMlw1nTZILFDjiU0OIu4uRNQURNFMY=;
        b=PZTvr67ppmUVLZIlFJZHmO3ILrli5rVXQwnkX/lkx7FZpZHTWZIGvvhHTLNBFCW6/h
         nvb02yBQRpI5Ay9xFhWn5qsf+ikzUPEJvRk54pOaXT2W6MC+jDWyzpe2o5ZafpUHsdiY
         5ov8lRpBCVFjgEO1GwyFjbaKuF94C5Da/R4my7QALjybqwm8ib6N6FUdmlQTBLzw1LN9
         5S5xeIQRh9CCW9AisPBElv5S9SE5L0BtaRFYs+9vZy7LDs601bclKRLJf6KjQUfFGx0f
         Dc8RBzvBFRGBp5v4AnoDPEGRxg6zHYjcqvxqXSIhZUfhch0JimGt6ZvIu2IUa6jNElJH
         uNEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684908; x=1779289708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfdsVavF1ADNUkRaWbbhdb5o1A1seHzrAfprJOgGQ1c=;
        b=frfdm/DG71+ksjIfiinp4XmA3BmILCicxzWZc9plwm2IJBFikUDZsTIfnWdLQaw1Cg
         R3uWcRmZsJLg8FhIgsX1qajEsfZqlEvEADxhU4jYri/+xdrON8Gutnp+wmn0yC7kxQi+
         myzrSPK6q6xtrRGSpPeJMpR0VJf5C5o42vC3KEHOwVf9R0MrJePVtrc+tFS3BO7E3Qxg
         wwH/UuS+RSIZkUJonDqaumx7nXwd/BgdvGAqYgN8uH7Rw9iEgPmksIQaOgJTIL0bIFXF
         p4DfFe1kJLMIItlTaODpYwA/es400ylRhLWklc3ao60cJ2sihMd3a6/mnJ3ZqhXinEko
         2imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684908; x=1779289708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfdsVavF1ADNUkRaWbbhdb5o1A1seHzrAfprJOgGQ1c=;
        b=NNR4zby+MjFLLLSDbiHyV8AJsuqhAZu62y/L+iEA7x8NCBni/RTPOJTSoMM5ML779D
         o4tWTscB3uVuH4E9FMlNXPgAnZT7nDMk49/vlCOoycqHFk0YtKmeVcC10xHQw31zw0Fy
         9M2o8yPW86GGS57005nclUCjq5J2OPuWTd/7cImJIGyDrSMbpByvnnE4QASmAx/R3aeg
         UKBQTw4TcP/y9egCWnaqI/tKMZ8Rmmradg3vzhJrZVKEy2vEEnXaRMRDUK4npWCPVoIV
         ebNF6TJZdTqX3nUUevjj6wp5qvkX0UlJHe9duD2rwXarKKUWIJ2x4JuVARHm1aS/3S9N
         hzQA==
X-Forwarded-Encrypted: i=1; AFNElJ8t/UJHEzJtYm38J9/SF1EzK04Y7++VqDdktm6TYxpnDtPf0D7XbXgNoYAiHI2T05HxeYRrssOEctk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSrsaHBFR3ZkdfroXX6+6SJinMWGoIzDARjUVPwnt986X0eZj
	vCbHT3D/r6HHnUzl43wgQufjjy1DGZkBMkHhT2D3fqWZmJDG2UUK6TOmnl34SyBF6wMmZkcg9Kd
	ME75vsMh4tMt9f3J1jLdXMyP9falWS8v0wNjfmdE=
X-Gm-Gg: Acq92OHggrK2c41SmeEYjm4oC22N62l8BvGLBgLWXEGQoPD67EffAQpkYt7PddRS+CK
	KOw26xXp8K0jRQzceoikf5bv5w1CNDtExGgsDjjb6aigEJEC6yUHihagDRVtsV1Bd/2q6Sb6R5p
	bv7/yIWU+9yWlM6jgbpT4olyUMDox4SmoBRPQBmG/MAQidLCVqPPLfiMQeu04/RN0ZeKUlFC3DG
	9nxP3+1Lql+JyLMozFeJq9VriwGFN2j2PGT6E6UQN+WBRJ4dlslwvStyaABV+CGhPHYpBTvwRg2
	SmdPYs8mIw==
X-Received: by 2002:a05:690c:3481:b0:79a:7157:879 with SMTP id
 00721157ae682-7c6dd2a8f86mr28172257b3.50.1778684430546; Wed, 13 May 2026
 08:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513013638.147606-1-m32285159@gmail.com> <agRfpI_eqG7QHYas@ashevche-desk.local>
In-Reply-To: <agRfpI_eqG7QHYas@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 13 May 2026 10:00:18 -0500
X-Gm-Features: AVHnY4Kbv751BmzfoNU399-2gX4JpWDdAV2q0rTvy2qYXNfGWdvRLPNRB0kR6lI
Message-ID: <CAKqfh0FbgATxfz__pF4WQx+pgxJ0s-D9S6bH8Lcky9npy7jrUQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to
 time-of-use race
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, sashiko <sashiko-bot@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 6:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 12, 2026 at 08:36:38PM -0500, Maxwell Doose wrote:
>
> The Subject can be made better:
>
>   iio: imu: kmx61: Fix potential TOCTOU race in kmx61_write_event_config(=
)
>

That all sounds good. Will wait for Jonathan to see if he just wants
to merge as is, change the subject, or ask for v3.

best regards,
max



> > A time-of-check to time-of-use race condition exists in
> > kmx61_write_event_config(). If two threads enter the function at the
> > same time, both threads may pass the check and get to the lock. Thus,
> > when the first thread releases the lock allowing the second thread to
> > start execution after the first thread modifies data->ev_enable_state t=
o
> > force returning from the function, the second thread continues executio=
n
> > regardless. Fix this by moving the data->ev_enable_state check inside o=
f
> > the critical section.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
