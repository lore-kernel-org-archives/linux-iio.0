Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD525783C;
	Mon,  9 Mar 2026 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083715; cv=none; b=KDA1vacsKe9tzwZlJDNgY4fE4bOfHbc/O2u/JiJ6ZBzr0b/AMDYS+A+DxR7CPIuORUnZNB/COeGD6I8wAOO2yK6bXr1t28XWBryIc4PTxmKvWrC7VN4m8pzkWPOtOC41ca0Wd47Y+IainiNOMMe978gDX0RTkHfgQzSJLLzhJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083715; c=relaxed/simple;
	bh=QuUKoKr87a28QvLjs3hiY8nRjj94FPCaL7geybQtFcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtiXqtkf8aRx00xrHeBwdlwCdek5o5K4a3Bnz6uVpbU5VnCwmGh/tGfEn+jiPb9WGAJQ1Ul24m/xwfgeOcilSknkEz9f8uNSJpytEgeNSuci+e045GgGtDpFLHMWgnof4lsxqgmmwR21y0/0eH/bLUN5mYah3jDmJSLUYOIS2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrPO3N8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrPO3N8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8465FC4CEF7;
	Mon,  9 Mar 2026 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773083714;
	bh=QuUKoKr87a28QvLjs3hiY8nRjj94FPCaL7geybQtFcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZrPO3N8bNgqZ2bCH2HUBbU0oyxKE1sa7d8347bvBkHgDZZlni6pnJdPLbmNc/MrW2
	 QyXCuI3aQjW6G7wTzdXsShmfw+zXWLlPULy5rn1qwVx40pGUt9LAYW9h0vz+8vlVov
	 8tGbE3lLhBG/EPctTlXozlA4UyCYkf1prysuam0/+DfvievE8bPhk5/D9TtdVq5F42
	 jArfSD1QAfNQgH34gmVgkJbZvpxDv2BwIlvScHbrqCPCT9mn3FSiBhJDMDmdVGaPXj
	 Cf8h5CKKV0p1P/E5Uzs4C2yR8Hfr2b6a/vNT8tYERX679YMkVuBbAR1gF07ETsUUsH
	 P7jNKtXxoCGoQ==
Date: Mon, 9 Mar 2026 19:15:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: accel: bmc150: convert to guard(mutex)
Message-ID: <20260309191504.616a9bd3@jic23-huawei>
In-Reply-To: <aa71SqlaSrXdpl89@ashevche-desk.local>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
	<20260309153408.71512-2-rajveer.chaudhari.linux@gmail.com>
	<aa71SqlaSrXdpl89@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Mar 2026 18:28:58 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 09, 2026 at 09:04:05PM +0530, Rajveer Chaudhari wrote:
> > Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> > bmc150_accel_buffer_predisable() and
> > bmc150_accel_buffer_postenable(). This ensures the mutex is
> > released on all return paths and allows returning directly
> > without a goto label.  
> 
> Wait _at least_ 24h between the versions of the patch or patch series.
> Let others give a chance to comment, review, et cetera!
> 
> So, based on the discussion in v1 it might make sense to have a sorting patches
> as precursor for each of the drivers in question. But since it's indeed cosmetic
> change I leave it to maintainers and other reviewers to judge.

Given the code is being 'touched' anyway, I'd welcome precursor patches
sorting the headers prior to adding a new one.
Not something I'll insist on though.

Thanks,

Jonathan
> 

