Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541943E7168;
	Fri, 24 Apr 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053215; cv=none; b=nhftna7QAnn1+bQhgDBiiz1bxxCwzvfH3Exyw0YtEsG4TcRL0ZpZO3P0DJwya/lKpt2R2NsRaRTg+pPCvWAjJPv+5+lCOn5/TqbPrgmlfbe3qvD/aKoVTLO24zBQoMYplJghyG0Dyb8ltTvPse1ybftnlgWTCWMMx5DnWjoGMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053215; c=relaxed/simple;
	bh=8MiFVOL8pqE/jqmzctH8jeJa4QIQG+8++LO+dGmbNLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WM/OZ2OVTQg2M4zoMlU5/MXyOymNhcLKJaRp/qlGAZW+JBovD+xUM+KqZdzCEw+hXlUXobYJD1s6LxuiVz1YK3xD105EGiDbWekoPDy+64AYIG0R/TIp/KGiAKHiCNV/FRUOgfiSW0wFo9grFhcoF/49FlV+KZE3mVfePs4lrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5IW6mro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5IW6mro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1472C19425;
	Fri, 24 Apr 2026 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053214;
	bh=8MiFVOL8pqE/jqmzctH8jeJa4QIQG+8++LO+dGmbNLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5IW6mroIurHtjrOXV7tr7wlTO3ZMlI/+kbPEBH8iZScH9J5LzlgDEu8mCyhAP4Yj
	 gffTUkN4iv8I0wh641ttnadJNoYAIRqF5xV6ErMehTDVE4wOqlmJPuiQZhEZFWtGL4
	 bK+PUx3+q4YxKRXs/67NLWue/BVSWpACm8N/iDRew4IHuEAe0Gfypa0EE2nfxgMT/D
	 v58Q/snr7H3kj+9zSzw/Bs5kmgM7daVfhToqEJwnnxwC6uWgEuuUjl7puL5gJBlwHJ
	 AR3t1o9EJhOoeKcO93xB7SgJa1EvIGHSqh3yiDWJEppIxGPmtu+6Qr5lbD1CtrFF4l
	 9sQpeJpJ5Lk/w==
Date: Fri, 24 Apr 2026 18:53:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: proximity: srf08: Replace sprintf() with
 sysfs_emit()
Message-ID: <20260424185327.66914793@jic23-huawei>
In-Reply-To: <aejE42knD_s5rsGy@ashevche-desk.local>
References: <20260422124505.8875-1-m32285159@gmail.com>
	<aejE42knD_s5rsGy@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:53:55 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 22, 2026 at 07:45:05AM -0500, Maxwell Doose wrote:
> > Replace sprintf() function calls with sysfs_emit() and
> > sysfs_emit_at(). While the current code is fine, sysfs_emit() is
> > preferred over sprintf(), and will help modernize the driver.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  v5:
> >  - Reversed decision to put sysfs_emit() call on one line per Jonathan
> >    Cameron's request.  
> 
> Oh, I missed that. In any case I consider my suggestion is still better,
> it keeps driver in limits and makes the wrap on logical boundary.
I'm a bit lost on which of us is asking for what and can't figure it out
from the patch history.  Anyhow, I did make one tweak whilst applying -
I think some confusion occurred as I don't think we'd disagree on this one
and you called it out in an earlier review.

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 2ec8d0732763..92a37ba331f6 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -317,7 +317,7 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
        for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
                if (data->chip_info->sensitivity_avail[i])
                        len += sysfs_emit_at(buf, len, "%d ",
-                               data->chip_info->sensitivity_avail[i]);
+                                            data->chip_info->sensitivity_avail[i]);
 
        len += sysfs_emit_at(buf, len, "\n");

It's only just over 80 chars and flipping to 
		if (!data->chip_info->sensitivity_avail[i])
			continue;
		len += sysfs_emit_at(..

doesn't seem worth the effort.
 
With that applied to the testing branch of iio.git.

Thanks,

Jonathan

> 
> >  - Fixed some of my editor's tab-spacing issues  
> 

