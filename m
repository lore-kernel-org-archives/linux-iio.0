Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39393E16B9
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843504; cv=none; b=pL923ETvxAbxQeT7sW9DvYJFJfg8FCsDf+j7XO3/naL0TFnGFjf8lDFV9sbin4/Iq7cuyXuR8RduoY1PzhdZc+NqCTvGESdPUZUdJlljxjuhM7ojjH9ow2aYMTfdJ5iORTHODa37DNG0L6vcoKOE4IXExx79kOH8Pm7YNS0zP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843504; c=relaxed/simple;
	bh=DqI51H520L+JlPaYmdlanDZ+YsNhQgc+JF8C1PvcNWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVrGBhcLreTCi2VufnvDMoDPKdfsINESKDtU2v+S2Dgp+lMbhO5y9T7D50bwNWfFiJ0ZY1HA1Rs6FJUntZ8CFdxGH73wvWKOfJLrrwnH1JjXp3S6zHowHT9xJaFzjFKO56Rl0hkFnHWyM4M/XLgOCTDQjShOgQ6+6cxGzeVJ+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNX3raEM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNX3raEM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4955158f26aso7765365e9.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843501; x=1785448301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kF0vVxev9fayaAXZA6hzrmNTUssyABm/Zi8r94t4pJQ=;
        b=CNX3raEM/dcjFKqqahfEVGjPTv0IvCiLdQsPuylrswtP6LxiK/HQsOSImqT7SrNQ6T
         TG2/HrhVE+2tKbqCGRRbOBfbsQC7MCU0r9nt3QVmYvRXPb+/0/9jwpL8XeQWreeDyklA
         /0fmYcOgjvTPwYQNeiZIDPl9sOIrCmHyIwmbqNW+b3PNzPT7+aksWAcKhtgsKAHr5cWQ
         SY/twKl4vahX/gibJALA14a2I5d6775fax4dcqjqgdO+Zffq097gGwK+b7o+E0DcgKLZ
         mn4+UID2UGwGDf1flmyO6pxBZbpp2MIHyhr3XWoZAwilJTiDhgDTJOvS4CXlwzC8/Chb
         Ktww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843501; x=1785448301;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kF0vVxev9fayaAXZA6hzrmNTUssyABm/Zi8r94t4pJQ=;
        b=Qh5XNo6rhgIL3jyTe6WGjnAGnjdn5DRVDAr9mi6L9+GDLXKi+3vEGLnRddRR9EvyQF
         /Dnh6490ZsE3vOP49StR9CbYHgafYPJFJNtftoZpqGZEDt24bbT6nsSqIoCqhLkv4Jgo
         XZrNclXXVa8CzD0rhISA0iWLoDIBgO9yHx/0ggVyszdqG243SS1CoQVe79lS/L9XB6v+
         hmWiH8FCHDEf1JTgUyAtEK94zhN3JnfmsIyRU7laiUywghEBMr8J+/rZIla87nhuTK8u
         ZxXHE1y4PW9hoeq7RCBzdG5cvXVlv8+160ksoTly4PjEKDsZWN83fTjKFHN1UIefmDdY
         f1jg==
X-Forwarded-Encrypted: i=1; AHgh+RoYt/uwmu4k2DDJtGyARSnev+dYXtlZD7qCtHa8XZ7qrh//NoeFd+oxax0s65TdZkXc2OmEN7a3zcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcq42dfHfrDT+nL9Mcy9CLS30PI5Hfj9vFbo8eH5byJjmw2Jxe
	byc94nohtZIjrJqwk6s/hyZB/zBZEeAKN/Lt5u61IkJc+HSRQvRRn37V
X-Gm-Gg: AR+sD10u/BzxX095nf2i2kVerPo14UD03gG999YDMrW9uSRiCx9buIyNOu3320fYLKi
	a1yxjAcYVZNgwFgogi/KZQ7UXkC9gyCSE+TLJuIc0vxt7QaBhkSEJsOA5154epSVQwP0W5LaLDg
	k2jjQMpOP3Klad6jjaATp9ZBGAvOd2HxoMOCkbePTafRzu7JYnaL/FCkMy4HU9KMQHLTtoItAmK
	7JFoAMUYHmDxawGBWZPhV6Sdj/GWp+8VhyaA+YwfSKRjH6QRV2CDg8BSW4VqejN6bPOIS/cgdkG
	+Qg+O5SXyjgKpYzTPKiFV/YKFbUHZaiynlegPQF3y/jzGm2oOzyDce4m8DJkMllKaElS4CQixbh
	EAUOzNQ/BZGLr392J/CSOJLgxLnqBEl12z1F/ajW/TIZk0VqA+WlutCMOK2CQVoXRQHbtrVHHbT
	aLCRSwdEAS3WCgDTfn64L77OKu0g1tHT0Nc96oxeWUJJcqSp123KqhLr/qvWJgASrnYClBzHart
	PGR8xGenC+x1bgH2bhv+AuduV/3tEaBiuDNOHioVDSnZC1mRjRYAOUda4V9O94RdGDG1vE8xOVC
	hNTL0jV+UuiiuSDTRhOx0Zbx1w45ltkldAoHRNdq8JeG5enP+usFKx2oP403Sxyqowg16YWgZKK
	6yjVDGHrItDwabTJk00yV9A==
X-Received: by 2002:a05:600c:3506:b0:495:699:5c8b with SMTP id 5b1f17b1804b1-49573cb97admr53579015e9.7.1784843501158;
        Thu, 23 Jul 2026 14:51:41 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af5d4d7sm23284635e9.2.2026.07.23.14.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:51:40 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:51:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, mazziesaccount@gmail.com, email@sirat.me,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: chemical: cleanup codestyle warning
Message-ID: <20260723235139.02fdab3f@systembl0wer>
In-Reply-To: <20260723161040.20318-1-adinata.softwareengineer@gmail.com>
References: <20260723161040.20318-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 00:10:38 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Reported by checkpatch:
> FILE: drivers/iio/chemical/ccs811.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));

Perhaps a nit, but I'd change the commit title to "prefer __packed"
and the commit message to something like:

"Change instance of __attribute__((__packed__)) to __packed per
checkpatch.pl warning.

Other than that:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---
>  drivers/iio/chemical/ccs811.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index ce7187ccd706..0e5c79b775a2 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -70,7 +70,7 @@ struct ccs811_reading {
>  	u8 status;
>  	u8 error;
>  	__be16 raw_data;
> -} __attribute__((__packed__));
> +} __packed;
>  
>  struct ccs811_data {
>  	struct i2c_client *client;

-- 
Kind regards,
Joshua Crofts
