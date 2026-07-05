Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D1282F22
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783279930; cv=pass; b=R6A/+5N/MPKlmF8rRHqW4d06sPl6IZeI/BrKcki7h2VZcvl6zpxNDxn5GXRde7SYfFv8QHCekcfMy2ARJqeg85bWAivTA8JU9pT5H45yCaejEt0Wq76ztp6ruJwI0O6EsozqVoaOD4MMJXQ0yD/ihHCqM3DR0bk+TvsENNH6swY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783279930; c=relaxed/simple;
	bh=LYZXiJ+Rs83JAuhPNbbWnteX8T0Ox9HzXuJDtiB0HKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj8rlc8d9ThCgLBsqxNrRX+Y5UY4quf+jqucC3gGe866jIyGU0kIRrlkMaXsa1+gJyWiRxbMqa79tX4IJd5syKJJqwOKpqal7b+LFRLlsC2kQtENtvcoi5+S/MRMP5M1pdVhtX7JtnqG9TJ3UbCdHKT92DpE1nswxtVLwWalpHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayYxeEHK; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayYxeEHK"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1940980f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 12:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783279928; cv=none;
        d=google.com; s=arc-20260327;
        b=X2jGxOgXBAGi/TlcEc3e/Ua1JokpHeKJN/iD2Dz0hb4Y+GP5V955ap0m7UD3AleqBc
         qaUl/zfCDZIM0bld6dIBwemjBtfnPDxIAgaXFRBil6EJvJE2x1frZ8ILHl8wUG8fr2xp
         xopUfazH8xFpcAQdxKgFqCPGQfiMDjoo1j/DuBs3qjQN26EXL4mVnGZuhom0NhficRiT
         qjX3b8Q/hsjQK0+Sx6TgMq+gZZeQETbt9NAGkvnzyZ/ff5La+lpsP91RtkC2U4zgw8G5
         eAgNgZQe3ssfsMfgF7kx0JODCJcchwhvowly+EbXrs+buA3NxMZMjphjZwF+FLcsB4yy
         JCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwT9n22fG/yr71+Qou8NPs/HxovuWX/nw54buxwMf10=;
        fh=uPds4LPCaIFm6OVVKTpn4IIQlgKgjUBNeaQnIKzCqrk=;
        b=grzqXSgLRIBTSBE4JD8nSGlHZPNrn+BSDOxaMwGb2kFjmQ8xyTe1eKosPIUJDuhI9V
         HiI1jiCG6ssx2iqxbhICeDSirfhZ8knHD+ivyu1HtBSduw5OaT5NZtUJhEZUCA08GKlf
         5/NvxxtoNvvaKd0f0JZdSHA/TSpnyydAJS9WydgzUuBjrmZK98HF/sD1wLeTrSHOoNKO
         i/ZF3h4BVbL4Hr5boAFJnF4RJb/Y+fQY9nejymO1mRo2zp9NbGg+C0UDfUit5nQId2AZ
         1IRVjv2G1zGjPjqd8R1i89g3zN1pbo7ddr/Aiqzhz+XaV0z2xAFbQo5HLvOI8TCpHpa2
         XmMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783279928; x=1783884728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GwT9n22fG/yr71+Qou8NPs/HxovuWX/nw54buxwMf10=;
        b=ayYxeEHKsNrxkTr08URUn+ovzwCpFOMs0wh79SR+YejBEguKktxXmmnsq3lG6xr3a/
         FesEHH+JV0KGAM5GSu3m/H4GmN2WEnAatai9cP88H2splr2qlWKT2Vn+RWW+mOqkX/53
         +3yRMR5aKYFkxfYIsp3fkZh1bWBZMNp3iIqm7ZYJMv66FtMbS3I29D/1nRcq3kbm46xA
         VO6sYkc3XJHoUKLX5SD+xffn2QqXXGhZnJbKQyAFuRRjrjVetXeSCfnqTd3WOJ1+f6Bp
         Zu9X5/+T0P3jRHNYyUCSBN3GkFZvTYqPzLYYPvkhFc+Pz/MBnXZPy9YL/bJdezdim7ll
         q6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783279928; x=1783884728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwT9n22fG/yr71+Qou8NPs/HxovuWX/nw54buxwMf10=;
        b=QdSLb1ikZ3j2Hos0okYFd6zL6hl8+Oa+4sk0/a3If2AaEBw9zsN+3q6JjjuQO1JdTr
         uzUqxU2QB3DSLkQl3yfrxsPIArb3atvXYd8JVcZ2JlxSQ0EgFufFzVAOYSIRqTVMQJr6
         ATVXc4nDp09yQ3yE/TRojrUGL7nhXrZaDFQ7XEg82MNTefpoOOOtR3sPcYA8k5AFQ2gm
         iKZRqb9y/OmJmcstzyPlTRLz826RedMgmkrYTUgSp7OfGOW9UlhBQRed87co3tAr64b1
         LupgqLkUcDY9O1dnHipeOAAYOZi51X+goMdGqoF2UsG3uNhVdv9ZSWD+vii5nKdoHtHJ
         0Nvg==
X-Forwarded-Encrypted: i=1; AHgh+RruHSdvrcj5MbyJ2iU8ANZopCAvvZ/QvXDdv+d9hOiklFKEcY9utVmEKDCNOkhB/zC/k+Xie7oun+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQwPVecWvLiB+h+FLowh+DIGPsXuD4tDaaLDrj4b8mUCimMeD
	sHCfL28X8cwzBYI0C9WFWwQHnpmKxjKW18Y1ZNSJCqa2JAZvbcGwl82TknakoTvj5T2cwPHM9Vm
	chQoYWhp9VpEvQroITMydOwXl02tQiDQ=
X-Gm-Gg: AfdE7ck1l1SguYx50Om6OCaEGCcKEP8OLz/dWIWXGyYPSVDW6uorVHGyjOBiUJil80S
	JYjpYy7VtekqI/dSeDsnl8UB03qyTU1d55w4D1bBWzXYWU890WluofA3rc8/8QRAp36wIL3aWmw
	27f0llz50P1zyYuMAsWvx+QpqD7amNPBGOCsLGB77m6pYlyZhgHOMoLgM67bjwdrzaQMiLsERGQ
	+hVlLUSOSiROiIDomIMK7b1fSTSKgv8uNtXi0K0GT0Nso5K5apOthjWCcfosBkwmUQ9aylVIHxH
	KS8rioAWu3RBUykRQr2OoFrMxdVVTMkQCywzTP5KGtmu08ESpKfQasgKtQV4jgBuYpfIuiKgtyX
	DwP3KhjJTorWn+q16Iz4kFqwzg+mlbdPPyUUquDRZGwfxjkCDoLVAWaMZFuX/D6fFFGAZi0s1Oh
	7YgWdtI3a2eCl98yZdj4Fn1P1svX3I64PHj2OjUrndT86Wb7NvL6u4/2levWB/3y8=
X-Received: by 2002:a05:6000:4203:b0:477:80fa:f447 with SMTP id
 ffacd0b85a97d-47aadb13c78mr8524276f8f.43.1783279927535; Sun, 05 Jul 2026
 12:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
 <20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com>
 <20260702182205.388efe24@jic23-huawei> <BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
In-Reply-To: <BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 5 Jul 2026 21:31:54 +0200
X-Gm-Features: AVVi8Cf75_SzN2fEHjfHXicsKvv5otrzKJC7UoPu5AQnM92pGFcWxZlA6a58s_g
Message-ID: <CALoEA-wkbbvPA02JFCTuCEQrpGKZfu3NeBScTErTT07U7zJZ_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer checks
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Maxwell Doose <m32285159@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 5 Jul 2026 at 20:17, Sanjay Chitroda <sanjayembeddedse@gmail.com> w=
rote:
>
>
>
> On 2 July 2026 10:52:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >On Thu, 02 Jul 2026 21:48:00 +0530
> >Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.=
org> wrote:
> >
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>
> >> Replace explicit NULL pointer comparisons with implicit checks across
> >> HID sensor IIO drivers to follow the preferred kernel coding style.
> >Is there anything in the kernel wide style guides about this?
> >
> >I do prefer this style in IIO but perhaps we should document it
> >as local IIO style rather than implying general guidance (unless
> >there is some!)
> >
> Hi Jonathan,
>
> I took reference of existing IIO commit message and followed the same.
>
> There is no kernel coding guideline for NULL pointer. If you think it wou=
ld be useful, I would be happy to work on documenting the preferred convent=
ions under "Documentation/driver-api/iio/", for example as a new "coding-st=
yle.rst" or similar document.

Not sure whether any coding style kerneldoc mentions this style,
nevertheless checkpatch prefers (!foo) over (foo =3D=3D NULL),  see the
COMPARISON_TO_NULL section in the checkpatch kerneldoc.

--=20
Kind regards

CJD
