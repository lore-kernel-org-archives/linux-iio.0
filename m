Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A9480DFF
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205796; cv=none; b=T2+BDjr4WepKFtzDYUUTvTh5sYWKiqF0bM6//YeOnXgQJK/M0S+JpIR0mt8zXAAdIUyLj4ICkkSn5+zuLxTwHq50Pbx8Detzsu181vOKh/dLuCy14gMatidte1zNqSzpHoWMMbl39fBA0YeIoJ8nKCMnNEHVR9V40BNjcaCCI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205796; c=relaxed/simple;
	bh=eoF04e7AXzXrtoHA5vbEeVEWVJAtxGhk82/yPBy1wzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhxi5dHDj8Zg3KoFgS5snULvDxPzoa7TPzKlGct51AbkqpsrEV0mjXI4s+VqpDHKDHbmzerWBumBjPKvogqd2cWxIFmw1fkIrvNv7YkUlL3F3bl4OjCMWvqoOz8DTFnDy/9gkLdvUPwSMMRhxwTxQcO3TbPgchrOBJPAfMffhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOqe364O; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOqe364O"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so871409f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791205793; x=1791810593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ck/YSmwX+BAU8aauMUDi1gthqNGVLuO2QlzjEMLfeNg=;
        b=KOqe364OWGyyi3FmB4T4oenpfXYZ5MiOUa61Jz3tXAJpUuKYOodV7PJIPKIptSMpXR
         oTc1AsvNXGqdbe9VHi5yXb8Wa3hbuu/A+C18h60zbjO8PZEYtOdEEuLdFq6KyCe3A0sM
         ACSArm0h305Ubopm4KEHI2azuzliyVqnMmr5Df0gJWNxVH7IzxGnXNYahxBDrlThPnLE
         jqcjMXRJZ8Qm2DoN7HpqDQeo9h6js6fcLBOXhFV0VsWVBGFKXk1KUGGw3/evdPxGd/gZ
         oi0MzLb5dQSd9mf4fUNpeV+0jeY7PxNLNwx81tcjz0JV0OyzixXk5VXDROz1lEDionGo
         qEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791205793; x=1791810593;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ck/YSmwX+BAU8aauMUDi1gthqNGVLuO2QlzjEMLfeNg=;
        b=0lCtW1iTMEdG6pH5C80CyPyWhEPAKSTzOyF7aOz/RDDlfkIU9hnjoMsTcmN6r28mqs
         EIC07tSEC70ZCYmazFsiau1zPTL7N6ik6irsUijOmEl9S7d1MWzN2loV9n7vhe+Y37xR
         Z3iFDBkQQak7hLKPWj1BlogCCSMGrv5C+xj+sb52eBSXP9XpVzlwYZ25Wjf2Xx3MiIvs
         RQLNxPodR32tkvtConfWbGjpE0oPVbSU/AUBPArqtaj6scyOEBq1OJ8LT5zEIci4h/VD
         o6BeL6rJxImAkckVxXeNvRk3I9osyX8e7LAjR0eiD0rgwndmAj+RQUThxLUXEri7AYqs
         dTvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhSxd+aI7cxrOtaVhi0oEpsMraXqdaVN4NYKf2ZHU2TEjmESszVCeXQOmTsk+VtJy28WY/YnAG6X4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXXVf/3GC7EK49eATq7K9iA80vh+ZSnntOwyQdYMny7tMUpNoA
	uDZ+5sCVVFbiovkCZ5sk/u7Agaxpg8HSd4XEb/aTFRfj3F5hkhawk3Eq
X-Gm-Gg: AYBFou19auMv47/qSu+rMk4alcmULH7oYMZPiPqml5bqByNinBie0uAcBHvqic7eAd3
	Up/92w3pOWJ8NpSl6HKrYSiXZFj8vYfJmj6ZU7nP8/lI7dS5VlcLOXVLTAF59YNnY0cMhPvtRMz
	u/6T3X1hHsXHqBmpEvdpnmLb51ce1GG5aBABh69FstpaJmwGhxQ4lDanlB5eTGBVWlRlY1pbEp5
	cBZNJjoCHoEs5G93JauOV6rLF8NKVk7pKCqbaH9rEwWXcMb7FcGgGOXYbsj/WB36sOGXEmLhBOO
	OPFaVomM3n6p51YESFVaD76UIZZJbdifTxkLadyLHsOEJ4of3tz2HuENzSqlNxGY7mBwittlSKd
	cXHUIcDITegYV09Bf4WWYsi6MVTrrJxsedfuWTTRywqxFwqgA70OYpu3WACQR1dI2Ck6yDWUv1b
	BJ0f0DfxY6RQfT3czcBl4GPgttVInNJJCQS5+3Af6u3/1RAJVEvWiK7gjUpxfu5m65wJB/4DpUE
	SzUgDvDhaK2ShYfqE9PyzvUqOdAjpp8QFKbmfgr9G9NfdZO4YESQNgEEw93fskEy9KuN+UPbcSQ
	ICbgNKzSKLMUp23rt0h2jQ4NU5mk/nTxenM9ONEc6zHkgaiqBOuK6sbM5Zpd10KiEd2Y3n1Gg2I
	5sAWPFWAHdSHC0VSeBjd+YB71MEAD23tD9x6BPblTo/DuTrXStBLMDOXWHWy4Hejsi20rFLUGNp
	Zk8KL/J3J4FWpwWxM=
X-Received: by 2002:a5d:64ca:0:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48b126f542emr19074352f8f.4.1791205793268;
        Mon, 05 Oct 2026 06:09:53 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6228d716sm3851685f8f.24.2026.10.05.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:09:53 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:09:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 10/15] iio: adc: xilinx-xadc: Add clarifying comments
Message-ID: <20261005150937.000044b6@gmail.com>
In-Reply-To: <20261005094205.1045874-11-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-11-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:12:00 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Add missing comments on struct mutex and spinlock_t in struct xadc
> (per checkpatch.pl), and explain the non-obvious FIFO-drain loop and
> Zynq alarm-bit reordering logic.
> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
