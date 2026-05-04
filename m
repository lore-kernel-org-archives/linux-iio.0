Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F5329373
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890330; cv=pass; b=k37pM6K01eirnMyTBaNRcLY3Hu8Ee+bAsZl0DEp4u4EP1KLJ+jnCpzR9D0Z4ZjB3YAk0szxie16jQVSAUD1tQM9tcIAkTmij19RRqT63AUPLjqFr8SfuDGPmVapZJZNohBQ7kC5myFaFPineZJ2gmHgK+M5kAky7KLtEiLm5OzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890330; c=relaxed/simple;
	bh=8RRm4UcFqM71UrAz6QvoFJxAuoNEoH+cnVHnJz4FhRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6d206M20BDR9gt2PLtvZt71HbynVtXKbGNkeXHNfqJsIPB+/n3IdXtpax3toO1g8ufX+8qvWjA50Y5QnvH+QBe0RV0BlGrvKu/2FGFn4lP0Fl+V0JeOiX8AQTu7sreUuXcd3/rxiHbTkZxTuTCBDl2XH5hTK04pQ6SSCU1dNXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0h2Iw+R; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0h2Iw+R"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449de065cb3so1472369f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 03:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777890328; cv=none;
        d=google.com; s=arc-20240605;
        b=KmoG0QvHnYRkfZQ7NN0DFIY/XJXLUutjLpTasZMbwP2rFd5lsvnpSe1GqIfrCYoSG4
         lnH0eV6jO5sSpBTO6HyCRg2g0f7ktTNGrY4gvE9d2QpTmy0SoSnh0+RhCSuuTpOGbRTC
         B5QmbGAf4f6cWwY9ztlrUgh8vkVJtpVnslXirIcjYUQml1oT1izYMoQ5Bu75BmWsKWzA
         T7v3tGzyflpDDM/qexbUguUCAQ4uyu+TyafcvcKYsXH35Olj/Y8HN787NF2P5mvtinCi
         UobX9kI2tv6VVt3S2QthLKpr2/wbvrVoKD6v0SJs7NTb2bCiyezXQ0HLWnnwEAH89974
         V4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0CX04gA1SJaO9my9kIbUxyIEbbDyMfY60ApnNou6zpI=;
        fh=tGkoa8jYZINOrOF9/mCNYT5Os6o+/KuMPixQq/4qd2g=;
        b=Z+WnC7O4LKCy3hEud2nuKcl9ONvaUTHRadwWkMqTcNHAMZD884PaAfh3Opo6POQLfK
         68TMMTahajFepA+TtnhsKA9Zgo1iABO1ZzKztUppzgH0nVVdA4qA76GtDci5I6OV+fZW
         l17IBX1HUCDfLkVIxymEKFaxsPpOzPiqX5w+qJ8zfz+62PwfLMR2J2++Rk44hXdsIp+8
         6Bz7XgoVNz2nROTeYiitGBmLG3HBAV/oATX7F1E2sxxg3Pk+V/gJC4jWJWw+6+m66TP6
         84uCjd6nvzAWtpWmf7eHVcGEjUPgMJqTcB8tZfyi4ZPrvjvG4nU/fTgXIxHrewhsHb/b
         3kiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777890328; x=1778495128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0CX04gA1SJaO9my9kIbUxyIEbbDyMfY60ApnNou6zpI=;
        b=j0h2Iw+R9b8KvyiiybdHAWWrCBhi//8wEiwvtcwCkdHunYtTc6bL33S7aFCQQSZ6ol
         +AzezFZ2K+xYSddl7ro7JoVdSRuc4ldsxBsc68wniNkSjszWk6IrQHxu7LrNTxmOKZwQ
         Mf2DW0P8R7EjX9EbijbmTU75MwDxvMx0xSCaqSa6jwfHxtK2fn1Ll39gErk2WGeTu36l
         jQRTS4C7C2Y+ok8JRE6vlP/OXo+9m9i5i4/61c2cXKy9q0lm1k1UnkDDkBwuJGIEdt38
         rfG3jz5YTYXtaIschzN4kEUVyJZTA+ZdXLVPrn2JptLUQRH+RyKmDfgg4DMzcqMn47jD
         CIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890328; x=1778495128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CX04gA1SJaO9my9kIbUxyIEbbDyMfY60ApnNou6zpI=;
        b=UTmL0rNYF6GhY2A0bS9uJNLw14gNJ2HDXcIsCarzHJinaLVzkJWB6RIKpUyx9h1cYm
         8j8rI511kHg5T67WlnTASfdL/+cNu/5kXHSEOEwhag3xp/1LFpobvRqduJkdlo+BhENm
         hdyME/PuBCRgbi3eWbloBU3h+wJpZ4tJ6+l+ATDd1ggq7MMRdmWOS48c6QmRf7qn0AbO
         MYdXGFU+Dt4x3h5XOkXtjKOxxD0tjCfgX2M4XYGqFhjIjubfxu3zpUthMYSwfXXClxCv
         kYmJ1CZBhYhTmvpYA5+GFplLnb/IJk/jvWOQM9ThtWNxhqrfoWb858lBRjrDOaiu3OpA
         ZLYg==
X-Forwarded-Encrypted: i=1; AFNElJ/MMXRity9w/r6u2RrOugnHOh4zUZnPiaf67Uy9XV7UZnCxpq1fZ4NQAXNtBVHhIaeVo7w5wK+pptw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrael3QepuVtNObHN+8WcfQx0mvaRoEFa2iQENv5Cd57tYo52
	AvCW1OoHCtmWUAHpbsM5aXL0fKDiKqy1EufX5tJH8qlNxoPDmaWwOEFpdJwaSJNvFoo2xyWl445
	gTLIRswDGlr+oQsKl9KTYu2UzQf/Zty8=
X-Gm-Gg: AeBDieuQ/viugUOOUtaHka0y2lTYv/vYkW7uToQ8wbAMzSuGImcHWizy7gt6X8vpCQd
	lx+SE7q/x17jYxef21fKCAT7bLTUUwvYPn8NxzJI1qJIFkZsL5VZx+VC0TdfjWSp1ZhwMmf3enI
	c1UMCE9vgK1+flPOfbYKy8uluu9gPWrJDp2xxLgR5viKtF+9icJy7sEOplwOeq8zeD3lB1Mx9Df
	j4DkbzZuf5TdSfgGW9vPlkH00L2R33yAWOGSnE2YAmJNLoYJ9UEMsdbrsd3sRGQ4giXVbT67Rhj
	eBd8cpQwPx99T1cRGql/nFMHeFBe6nIn2dqmwMFXY+xNI/DCyrK8DpgKgTraLFUem5edGGKUWI/
	vglqcqZHvajgKCfGnfZPhOeh9gLJj+ESzXm/rmwNoPTLwBukYJ5gdZRCjMPFUHMYpQ+C4OOptij
	6AlscFnzAFYJIGoW6V
X-Received: by 2002:a05:6000:2c04:b0:44a:8c10:40dc with SMTP id
 ffacd0b85a97d-44bb4dd9f34mr15697188f8f.18.1777890327531; Mon, 04 May 2026
 03:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260428173540.28b7913e@jic23-huawei> <CALoEA-xm0FGRk1rUWOO1YvzczC86Bgvu-t4Fe4iy3S_LCTygRg@mail.gmail.com>
 <afhkdxsxDbUDqG9g@ashevche-desk.local> <CALoEA-ybX_RPQaxCviS03mHvneWzH-WxNvbgBMxXXEmrfc3fGw@mail.gmail.com>
 <afhy1bo6R48QJs8X@ashevche-desk.local>
In-Reply-To: <afhy1bo6R48QJs8X@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 12:25:16 +0200
X-Gm-Features: AVHnY4LJEdYM9F_DBHXId8nHHlkLQV-9ZnDYg82E3HGbqo4538oEg837jpB4z7U
Message-ID: <CALoEA-xo_yPqHF+DtVep8yZOjX=irVerygS8FsBARRVTZpxH6A@mail.gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to
 the driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 12:20, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 04, 2026 at 12:13:45PM +0200, Joshua Crofts wrote:
> > On Mon, 4 May 2026 at 11:18, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, May 04, 2026 at 11:13:36AM +0200, Joshua Crofts wrote:
> > > > On Tue, 28 Apr 2026 at 18:35, Jonathan Cameron <jic23@kernel.org> wrote:
>
> ...
>
> > > > Given the relatively big backlog of email in the list, should I wait a
> > > > bit longer sending the combined series?
> > >
> > > I'm fine if you send it today or this week.
> >
> > Is it fine if I do a RESEND PATCH after rebasing or should I wait? Sashiko
> > reported "failed to apply".
>
> Better to wait, have you missed the --base argument? Or is it incorrect?

I use b4, so the base-commit was included in the cover letter, but looking at
it - it's a commit from a month ago, so not good.

-- 
Kind regards

CJD
