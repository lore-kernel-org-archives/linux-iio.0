Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4A3CE0A8
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557392; cv=none; b=pZc6B4JnK/YfrZcDBJUfH59tzergAtOusE8q6lzrNlo0QfpGvbp7nBjeynU6Vt4VtqGtLvM4VSSMGsLdaKdxuCA42vJvyn7jPHwuFyP0Y6Bo8MH+Zw13DAJQjEH+l0ZSBuCe7pPkeAbM6ZrNopPXi8rS/ap1gbwd6gLHtwrNVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557392; c=relaxed/simple;
	bh=ipxFRwOMI9FnrFLgYfOuqOLFuYrkxm4d5w3ALRd0Xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4jRTnZEbJD3boqmBMAFX0MjfXHDjUDW6NfQbpmsz4FTx+8RVZyCIQwk4LhaM7Qt7+LPbDFoKpZ+ML9z6lTm4mw8bn+qeDqBpn03t4jWsOzzAnnRzuSQLQYT+Lh4VyssGru0aXCetspzIAdLN3tOMoYYIpJ1ghSY09L0v5K0Bes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebac79fff8so31948766b.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 00:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557389; x=1781162189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmuhf90GQCmtgd5+s3OkmfdSZyPGskYbQsHr9VlNV2M=;
        b=ZhM0n2V9Wd8FIwccI2lJg3hcHjEcdNVSPsah0i8RS6MvMiaNhbmH/zoUTopQHlfBOf
         6G6TZsYxJzfuplh5JKzguqILiyOqk8vPLG7xJR/XP7UXTmekkNYYckXnBHmMDKrw33Om
         KVoGivZau13ohauByVPZ46gziZWPDQb5XpmGYUHDpcMjlMwHFU+JVlMQ6GbJ08mz0VIU
         yDRuZN7Y6XeL2VLIf+U1GHrNgU1JClYwk8bfKn53An+ryFqUFQjF4pj35qtpcLDm2nCq
         2iuDqedNiAz4uICkYeH54R8z9s3ZC0JQlNFJhoH0jYTGRRrp4Qua6RisxHuHHV8xM45b
         x9Jw==
X-Forwarded-Encrypted: i=1; AFNElJ/McLeyINJGEYTniS1gfP36icMKBlLEt2jZHtYOeC3pgKjLTmKDNpqC9eaPSY0DjfnVItPjI/XgdIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC+YcEwOE0sR8l52PHvMzqJE114DNEHe4RC0TO9nyVkO0O/B5
	OiAMa6IbXBakt6uBMgHViFofa+cv9YNgi2YEKNS3npUjOFjWeTqnFApjgDE2yZvppe0=
X-Gm-Gg: Acq92OFhcKUuFowdZ+vMRBtgbsSwlBDRCPGj5MNI/s6gqwLvMrC7P1K/HxbPiVaAdw9
	90X/LIqSfQC6EP8G3RCHBoY5bkhGsR/TzztcdJ72Gg/2G6DIcId+cP2AsdpHHvNabG92MD8n8ri
	37SC54NrpVMXXDCRbpg+f9N4KSN8VQymc45vLCE/uZzKaszTDD3LPu2k2/9Itxw9Va+QuZ3tUhg
	3HUVt2UIbCrhAjm51/W/GJeftgnq1Tpnlyl4rBZ81ZufSrqKJIX+5kXxtcm/zmcbC6nmRK+RdEL
	hSDto+XDIBOWNzk23HbKL+JwTNgLpzukRAlSoSWjSwVgyufjRqVbwGKsbJT65EOwocDfA1evYQO
	EcZ10cAqw8QNTNyL49MWBF2WGEAcpOMYk3mCcfZYodf5IKlHiwnqGnOLzu4nk/sxG1vVGIw+DiN
	htyd7g5cL/opYj0Mp20s+mkNRijw51FexgKot4Zwu2LIU0bDP3aFftM2xg4PA2XtmxQLqJqWE=
X-Received: by 2002:a17:907:9486:b0:bec:894d:dd3f with SMTP id a640c23a62f3a-bf0aca0e75dmr345787966b.14.1780557388509;
        Thu, 04 Jun 2026 00:16:28 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9c499sm259036566b.22.2026.06.04.00.16.26
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 00:16:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68d2342c5e6so504683a12.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 00:16:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JNbvdu9w1a9gfhuVLLaj9VY3WH12Wc4U8rTRxRKJgTcj7yqT3MyGeeHw3+1CPkOiwc89nqLNDG2Y=@vger.kernel.org
X-Received: by 2002:a05:6402:3805:b0:68a:f749:608d with SMTP id
 4fb4d7f45d1cf-68e72932655mr3390437a12.21.1780557386130; Thu, 04 Jun 2026
 00:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202606040245.XfmRpBhA-lkp@intel.com>
In-Reply-To: <202606040245.XfmRpBhA-lkp@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jun 2026 09:16:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqo5C9epmE1idc15x9nByhVZP5Hdb5OKtOLSMakb+sfA@mail.gmail.com>
X-Gm-Features: AVHnY4JPWQVIpu2upPgjp37FxY__BC8JhXLs9bmbyscm7sasgK8RSPuLMSmE61A
Message-ID: <CAMuHMdUqo5C9epmE1idc15x9nByhVZP5Hdb5OKtOLSMakb+sfA@mail.gmail.com>
Subject: Re: drivers/iio/common/scmi_sensors/scmi_iio.c:247:1-7: WARNING:
 do_div() does a 64-by-32 division, please consider using div64_u64 instead.
To: kernel test robot <lkp@intel.com>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>, 
	Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, arm-scmi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CC IIO/SCMI

On Wed, 3 Jun 2026 at 20:36, kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> commit: a0e2cb6a90634f3dc80f16e882a683ee5761b0b0 um: Add VFIO-based virtual PCI driver
> date:   1 year, 1 month ago
> config: um-randconfig-r052-20260603 (https://download.01.org/0day-ci/archive/20260604/202606040245.XfmRpBhA-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e5ab4f8a1f766febdc65ce89c00dec85393cfd68)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Fixes: a0e2cb6a9063 ("um: Add VFIO-based virtual PCI driver")
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606040245.XfmRpBhA-lkp@intel.com/
>
> cocci warnings: (new ones prefixed by >>)
> >> drivers/iio/common/scmi_sensors/scmi_iio.c:247:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>    drivers/iio/common/scmi_sensors/scmi_iio.c:507:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>    drivers/iio/common/scmi_sensors/scmi_iio.c:273:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>    drivers/iio/common/scmi_sensors/scmi_iio.c:166:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>
> vim +247 drivers/iio/common/scmi_sensors/scmi_iio.c
>
> f774117c96f94c Jyoti Bhayana 2021-03-09  238
> f774117c96f94c Jyoti Bhayana 2021-03-09  239  static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
> f774117c96f94c Jyoti Bhayana 2021-03-09  240  {
> f774117c96f94c Jyoti Bhayana 2021-03-09  241    u64 rem, freq;
> f774117c96f94c Jyoti Bhayana 2021-03-09  242
> f774117c96f94c Jyoti Bhayana 2021-03-09  243    freq = NSEC_PER_SEC;
> f774117c96f94c Jyoti Bhayana 2021-03-09  244    rem = do_div(freq, interval_ns);
> f774117c96f94c Jyoti Bhayana 2021-03-09  245    *hz = freq;
> f774117c96f94c Jyoti Bhayana 2021-03-09  246    *uhz = rem * 1000000UL;
> f774117c96f94c Jyoti Bhayana 2021-03-09 @247    do_div(*uhz, interval_ns);

Indeed, most do_div() use in that driver is broken on 32-bit.

> f774117c96f94c Jyoti Bhayana 2021-03-09  248  }
> f774117c96f94c Jyoti Bhayana 2021-03-09  249
>
> :::::: The code at line 247 was first introduced by commit
> :::::: f774117c96f94c7c4d2f076e4cacc80218b0df48 iio/scmi: Adding support for IIO SCMI Based Sensors
>
> :::::: TO: Jyoti Bhayana <jbhayana@google.com>
> :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

So why was this sent to different people instead?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
