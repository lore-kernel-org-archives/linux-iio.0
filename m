Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4832288B1
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312859; cv=pass; b=UuWRj1Yk77TSHzLmdKhZhD0wMvN1qZS7i2/4tSj2eWYwuxX2VG82g5PuH0wCfoG6qtSi/WvgMcSuxXyw8g/kovCwbFZ1RA3WTsff4wPgtobGw/ue51D5VmBZd0b7/mPdGnXrpHU3jlJMFnQnMKiIHUVIPyhz1qLYjr++vlDgAtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312859; c=relaxed/simple;
	bh=r+diEcnvz077hMGOrFZmMu8aSDrUSyQswfGxYoQNywM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbaR6jf+CheiWdA/Ax+YpPT+n0wj4MxFa/7x7om90H1DvhOhRw3eN0YvyP6GC2VyvE4PMd6AqueDN6QDmzatcRFz6b6TjFLk4bngSfiJYTzFS+3+H0VcM7L6ZI79f3RWj08V+RQWkFuxth6D0ZVAcBhtd29K75mOxfNhKmfSoZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqQX5EDS; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqQX5EDS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44e5624c053so1527424f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 00:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778312856; cv=none;
        d=google.com; s=arc-20240605;
        b=N/dtNxwxxXjk1qtxH7sz6/9ebC4snHLOFPt3mWyg9zWkWuTmcQ95vR4VIeqPZ3YrEk
         3vmB/PQtuFQsc3QlGwTG7+3c6adn9Wxc1nb18s00SCOCPgZGCCACY/rX4G81RYgo38Jj
         ByxoUMG6DH7qGYL5+OIcgdrv2g+kX+Ez/Qen1aropi9MRgl10nGXYMLKZipPsGjirKeV
         nTJgMs9LZCY6GDuqA4ahjtZVfZ5Ugd25Rm30CoXUHNq+JqRpWNADJPVcdYq/OUu6S2fY
         1K8JNEXtTK9I3JgcfPi7v8ykyuJVZJqTxrum2YuYqj+dNya24xlVonFZ943XOJ68iAzz
         Lcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l94GY74ZDdLGDiZ0RiC0VEy+NzY+H4L/n9/8SlATGeg=;
        fh=i3RAt4kcpkgIDNL6TLF1wjQZ6gXUyshqhmODX4Jli/k=;
        b=jMskrpOuS0Pwi+IMn4SlsbwnnrViBYvRMg6RYiGfhrwPe+h0jHdA2V745iaiRTr/LQ
         OxlZQ2Ag4oCO69glrk71DcJHJy3+oW9xrpdZMbtKsWDU3cNijbotRqOboYqqWda8aUCw
         Uy46ybC61rUfVmr4SULWqT800w/m1YCYtSLaHX+RdlaGZHv078UT/53txeEpPRNsTjl/
         /JcNFiV49IioeKIE1WGjxiMMjeGqVyKYMSSQw2hm4t5H9q5mwTcGURDYNNubKNdjz8XD
         F2v6W15vhLhGch3vN877VGwWNLaWI/lscEOWvlv9yQQZREV3d4ptGHyquY/AwKDlobQK
         o8/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778312856; x=1778917656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l94GY74ZDdLGDiZ0RiC0VEy+NzY+H4L/n9/8SlATGeg=;
        b=qqQX5EDSHFQ8Ty2cXc2hbsh6a4Qr1aTlMH1SYRiM71AzpZGXB8Rm/xwwS5KtphsHGp
         GE66Ec94YFNX0ARePw8JjdDYdF38IbOAoBvy07kGFrit5/n7EUZcITCFkShny9lvBq7a
         dmSsTV6iAQZJdrWzW17nmOCZKnA9vO1reHMbgvUiped7REac38J4XY64E8+tgsH+g/Ce
         gxyYTduAIQdFPtH0ZFY+p13MasK1Mr1E5TMzA3mejGejDaOBgmEi0vCeSo2EuV35F0QR
         YkHnxfWp7FZMDjm2AbmObtf61drplYdOSnWqp5JXR9ZRv45ios5oxPNQUXLVIc+aEqY1
         Jmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778312856; x=1778917656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l94GY74ZDdLGDiZ0RiC0VEy+NzY+H4L/n9/8SlATGeg=;
        b=jU/frcDlXKyUo+ysOIiZA93NllGWBBlsokDbd0PCi83jMdlLI5Va43gndU3JxWMtN0
         42jfg0gJRcvWqG9vS1Q0aCeeQai5ZE1q4rpKiBNRFynFaZcGvCSRSW4f06FvUzNoRwn9
         hHnesV2ldL1JV38xnF8UMG8C07Gwn3ejRc1xw2/vTGvaUtoA2XuBZPFq5nSkNfVbBGoA
         3qV79nVAlZFCGY+VuG+ABs3PTPrUOGtFd6Pl4JxF43M4SHNpHIE5Y98PPaOjo3VpzZOV
         DtDM/Y9gFZKFv5yMkCEZ3JJxiUFp2r+Of0rKqdK99xOyHBARg0RnV0sxaFkwNKmltbMp
         hwaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CS15NKgB9QA+8L6yVLzuI4jHhM4+x5b9zO7wdsPZM2AVjW8MstmiUT+xj75xdcxhhNMwDK+eWd6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6WLkrxUe7zg2ElVCe1qpd98O+E4gKFUFTull9r3Nid5XtVJR
	eoFcjVZGZDMBARCn2Qd1/puWsAJIQW/tQCEskApKb+OEc1ZnI61399E21nhhbR307ByOedRLB30
	jegz0AQyNZfn0c56GOiRg+0XxoGfWitg=
X-Gm-Gg: Acq92OHyK43GC0ACLy+wS3kmc7UB0ORTK++Q3khsMYfr2Ofhv+f0/OipuomAXIS24Q1
	dnBQBgEYT8J1UbgzUvxi3dx1TMSyEzT+tdEf8z7nayJXp70oc1eLcP4x3rrYrjEPUnsmFjlz8+v
	znH3EAuaOPMxKcHSsSMfZxWjFUWG23DFKz3NqFFqIZ3C7P4bTaLc9F+9NEb/NBt7xygjGrhvBbZ
	aqriKiZVkrED3++PNWfiCycVUf3s4p2wX1nJSW8egFQYYEmeZQG92Yy2nH2xllMyOZULdI/d9sD
	gklDGcp3Pu6wA9U9GyNJHR50G1SFg6clcMXCbyBKNZLznkAiKQF3OqSaUTeBUKZDrw5/GcgQLjI
	lcP9Gf9yWStKiqA6eEbuWxAlGnhjjZl+G+0eZ/hgfRCZWmbELl007T0+4hxnYbunv4r1c31vgKY
	1npK1eBQ==
X-Received: by 2002:a05:6000:26c9:b0:44b:d88e:7ceb with SMTP id
 ffacd0b85a97d-4515d3dc4e0mr24872653f8f.32.1778312856031; Sat, 09 May 2026
 00:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <af2zup3PFlgs2DtE@ashevche-desk.local> <CALoEA-y-Qg22NSfVBLtqx4VFp0q=xqLOuL5Wf8TxW1AswW1+hQ@mail.gmail.com>
 <af7Zql3NkhDwKWBc@ashevche-desk.local>
In-Reply-To: <af7Zql3NkhDwKWBc@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 9 May 2026 09:47:25 +0200
X-Gm-Features: AVHnY4IGn7xtp2CJ06uCjzDy61W-XI86Kfe9jL3diPPeZKKPmKDtmVQuNei6OEs
Message-ID: <CALoEA-zBRC+sZqtP4YiSu8ZBgw69t9_ZqaOQ9BDResRWhnGR=g@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 May 2026 at 08:52, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 08, 2026 at 03:51:06PM +0200, Joshua Crofts wrote:
> > On Fri, 8 May 2026 at 11:58, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, May 07, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:
>
> ...
>
> > > > +     /* Only power down if currently active */
> > > > +     if (pm_runtime_status_suspended(dev))
> > >
> > > Is this one a correct one?
> > > We also have pm_runtime_suspended(), which is different.
> >
> > As we only require the status of the device and not the power.disable_depth,
> > pm_runtime_status_suspended() seems adequate.
>
> Last time I have checked the code on this I remember that probably this one
> doesn't guarantee that immediately after returning to the caller the device is
> still in a suspend status.
>
> The difference between two as documentation said is in "...if runtime PM
> is enabled for @dev..." for the pm_runtime_suspended(). So the
> pm_runtime_suspended() is stricter in that sense.

Okay, if you prefer pm_runtime_suspended() then I have no issue with it.
I can amend the series version this time.

-- 
Kind regards

CJD
