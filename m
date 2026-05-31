Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE85257435
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225333; cv=pass; b=Y98H3Faj3S5hch0/PrIj74vXJXYqhxQsQsTCGAitview9fzcpsahn8NnpdA9riKdQCsZ8/sEVtiYvv6LRw8Lvf4IOkCH22XfBoMBYCHaJwvujrlv51ARZF7YXqoemA+dF7kr1d34fhgwXr59Z24z9AjCXdfcbQnB5oDckcJcsmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225333; c=relaxed/simple;
	bh=6pE3OdVID1fqMndhmZnX2k+GL466xoFapVqSeSf79rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXVbLkccUC3sm9KpU8omIlIo64CULd0gIkSnEcNJGu2skRoUTWV+41GS7GF2g7y0CwSDOIvw1HsDdBnnlI9qbUlO+oNIs26t0dBUhBFMx/ocRgOLv2A/4exhi75uQgugLTWqfp/KHQllVyB2V+I0l1MvazW6CYh7tpFG/5D3OoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIg95dMX; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIg95dMX"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6a306fec0so733785a34.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 04:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780225331; cv=none;
        d=google.com; s=arc-20240605;
        b=Xl5p/HOzAUNAutekQhlpvzUQqCwMiFqJCAyonUqI7ipLJlWQjfaT0YNU3pWShxNTsS
         7r5TD1Mj4agxTZ0gdsFJG7eEAPXAZZ8UCKhpC2NVvtVNusAWIFFJAc69tONEXW4GOJ6j
         2aLa75ZBgyVJZYFJMnhB7pDILEvXEH57DLC5kHBGbUQc+J7a9kRrZERavYomv/TVc/oH
         Up4SzRJ8W8U9pmcqQdbmXNeJIJfhRUuY77FgZKhy1sOfyZOnK1FPw2QZHWpD/ERvijRX
         +3z9WrQ5+7TqTFj8V/9TAPwJKRN4spV6/O9Z7Q1Bvo13tESK816eOF/zIXrrOm8Z1q+C
         4/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pE3OdVID1fqMndhmZnX2k+GL466xoFapVqSeSf79rE=;
        fh=a5JaCOZ6whMI0VVOCTAtT8v5loS+Nqs89PK0grpzfL4=;
        b=CCwY3hGB62IJqqn7H9C+RUWYLElu1mo5zMrguO6ihjJ+4DXRrN4DkOdtmbnSTt9QOK
         u1j3OBl/Q06nhUMoTIKgkNKtmbCL0lCXmB8QD/F2g3jUapfjQb8Bfw4COIyrQLlvD0a/
         zflm5OcUkvuiMoYHhhGJYQA81nQU2O0a3u18CDrKcvVbb1on1ybORCs1/V+Zj4b/wg9A
         MIZ6PbtyUH3aF6yHLH3B+ZruvjpOZmxSBBzHcWqZmtMhUjx1d6O/5jWWPTY8qwSoaL0/
         qow4P4DVlq4liXwkL+IbmGrxAwRcyBTbWB4F5Cdqx7ZIUZ6/xv+HMUwTFgzOLXk16Q3w
         qIgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780225331; x=1780830131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pE3OdVID1fqMndhmZnX2k+GL466xoFapVqSeSf79rE=;
        b=HIg95dMXLX3bTUXUmqeeLFjNRLTWjNkp8dlXjKEBsQtzeqy2LydD2CgwVHtnqKbUas
         EwyZemIcxPOyfoZkEb5qc5+OL31SnghzziPeqWMfHwRLaPlmTd8qGVs+BOaaQxT9387O
         Eq2FyE580Zzc8rX9oeih+O2sGVvkC9pj39tnpcGQRik6QeWrAeic3oTyYzUIohpaHh2W
         4iqLH5x411kcuADELTe/gc043OU7pSdlv6pwrCvrMp0JGA3h+ZrfJPGDcr1UFd3dBUHR
         7Xe9Tfx2ur8kst5bILgt6cPN2HiUTkYGZgFahucZSzPDS/le2kUBRU6xUl9JR3Us5Gc9
         jq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780225331; x=1780830131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pE3OdVID1fqMndhmZnX2k+GL466xoFapVqSeSf79rE=;
        b=IRVbTfmV5E6DqIyOMm3x/8Y9OcqS0YIlifbnNyWSV/NpaYWfmhhrkXd9Y9+iC//bGW
         6YXhbHv0jc6ixrk1VK7gSUYvrlggqOEAob9IUHgb3nwIcb2nP0t4HhEhwTxTmPMCKkPW
         YdLHpVUZdTe+3pp89mXOVSeOLzntVSkAm/1wwAUlylNnFKNH03QmpamDt761bccEHqUv
         A/5UduxqdP7x/bp4JVNsaqkmvIAdXnmPsxK3NlhN9vaW/MygGyEFqu8dBwWJjk0P+Z1+
         rGnmBNQNLrQ9rY6ch0devaq2nARhRcl7qfaWgDPCIcTHQfeUQlmIlznUCK3uHgXX2Cho
         3s/g==
X-Forwarded-Encrypted: i=1; AFNElJ+TN7Fv42HPPZuVMU77qn8kY0DjJ7CxEWu8S39HdCycKt6bHnx6ZdiVS34jxxUUA5JPnabzeGzTlAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7p3k2Avi/F7wE1SeoQpGaUJpwRZ2zAnSXshk6/wYb9GOi89D
	8/ya64fzDcEfvoOviDv6IsXvIHvVJqZ2gx05PEpfXDrwD39tJgXnW596moL4yFikyfsDZQ0RBKt
	NyDgr795DOsTm+N8MWtew9FpeF/0GUZs=
X-Gm-Gg: Acq92OGwNB3zIkJzHj6vHcdhgpLYOnjlqVyXiNcRyXrgghpX0qaWcf01gWmIWPcw34h
	r1XySQY8Ucl+i1LSpVlhhdNHAHiKUCfWAdfXKuITIzbh7vfeu4fZFzYOeVLtlD/ZJfxRTv/lHzq
	tM7wO44x4q/dDxfLFmOd1bIejJeyrF9yOSdFOlRMhRs3LXeVQ2DzOSJVPL+pht/N6aQfM8ZAkPR
	JVSLDdy0XClkMldwM03thThB0Dd8uAvhOYf3cS3BZ4kxf9e2mFelrI/te1ssmKoq7aexBuLJGnI
	sOT+7x1GqxU9NxduY3D3YgJNXZo8JehxlQezTsfv23/if0QezA==
X-Received: by 2002:a05:6820:2982:b0:69d:8481:f9e1 with SMTP id
 006d021491bc7-69e042c2822mr4076172eaf.16.1780225331638; Sun, 31 May 2026
 04:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-4-suunj1331@gmail.com>
 <CAHp75VdMZ-HdJXA0SLpFrs7AZw90v+VRpbHgoiugwooG62cbhw@mail.gmail.com>
In-Reply-To: <CAHp75VdMZ-HdJXA0SLpFrs7AZw90v+VRpbHgoiugwooG62cbhw@mail.gmail.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sun, 31 May 2026 20:01:56 +0900
X-Gm-Features: AVHnY4Lh2dddIjcVcE1neswbhD90KkvzDF9Pfr4tDVYlavlO3_MiTALJRgDuuK4
Message-ID: <CAGwK=3rC_ppQLMFpchdY9uezX9O0z4VCzpcAGpr_vq5cdgmbfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: pressure: mpl3115: generalize interrupt pin routing
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sat, May 30, 2026 at 9:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> > No functional change intended.
>
> All the same issues in the commit message as with the previous
> change.

Right. I'll address it the same way in v2: drop the "no functional
change" line, split the unrelated changes, and rework the commit
message accordingly.

Thanks.

On Sat, May 30, 2026 at 9:40=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.co=
m> wrote:
> >
> > Write CTRL_REG5 explicitly for both INT1 and INT2 rather than
> > relying on power-on defaults when INT2 is selected.
> >
> > This avoids incorrect interrupt routing after a suspend/resume
> > cycle where the register may not return to its default state.
> >
> > Route both DRDY and FIFO interrupts to the selected pin. The
> > FIFO routing is not yet used but is required by the hardware
> > FIFO support added in the following patch.
> >
> > Consolidate polarity configuration into a single code path
> > that handles both interrupt pins uniformly.
>
> > No functional change intended.
>
> All the same issues in the commit message as with the previous change.
>
> --
> With Best Regards,
> Andy Shevchenko
