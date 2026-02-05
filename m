Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60A3EF0C6
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300360; cv=pass; b=eXwFm1rfHLiC8P8cO1Dakuh+AjOCtaJqarz+Bjo7gziLfwyCMvnl7poDn1IbMTo96NQYL4bggrE1bpLfv89yL2Zpoo5IwbEPf83SrwJUXt8Nualki6CsROMaD6wVM+9NsncQ2syi1IdFlN6F0J1trqgQbc7zkKVvNMpi8zDnNVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300360; c=relaxed/simple;
	bh=j8FCb4vabMY+gKn/7Nb2ukANe8nmmjl0EEbQPlT7obQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ph0dUQJmJqeIYPVZ23oXMRwvodzX5ShMpS7qYr1O0CkxDG8t1hQjbNUHqkFenW6Rp+b+bN5d9auEPh61lvaxY36aFX/F3I/glg/K7bEAhrKYxd1E5K+tLKdVmKaHwdHrJnDEMKNxxRZcuuLnz6pEd7VsJMIldWBBQUgS8Ni5m4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYYcthU/; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYYcthU/"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64965ee303dso1077627d50.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 06:06:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770300359; cv=none;
        d=google.com; s=arc-20240605;
        b=dI6GP/UfnphgX22vh7ZIOL1KDl+FOV/eJr+uBgJh/Jqca6ewbbS+Uf2Wh+lm39ZEVa
         dhkhrDgaxFIXz4VehZPvg5m80YwI/GxvNGsujr7wTkGpldZFEvosLo3Ho5Bwez0wyisj
         2kAwbLkYzEGomoySU58n0QwZn/zht45st86O3lqvcyK5lVXTM8D1ONcY2yUybV6xSquU
         K/0/By0WvnvvvA3uSZ1WP7+fjgyi3pTVWuYbU2kpUyM5RmlGTfS2CLryDs2FB8cGKeTo
         BsKiCmfe79a846rlRm7r5+5laZSSa+i4Xw7fBWjsMYf8B1vGPXN7owPPCAZyqr0E1j25
         i4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eTuYUSmqaG1nhqzwiZ+mkZFjwLolxYQJvYVxP3N4y8w=;
        fh=coa/baojGuKDc+U2MWD4bZh6v3vE5wnvQkPvDY3kvsU=;
        b=OkNMBc3Y1zA+gy+OzsedZeLbiWNr40rAOQHlKKvUyZYuUGD2eUbfd6blHc9UK13LSe
         c117WRDyEN51Jn+3f3FAObahGCOmhQVGgPI4lm9J45Pqs4PG0x6AYTgsJpQ1b0yn5mc+
         7LpIKZiSlhW18Mac73JWi229Dtn8iXH+6TG27VcKaUIj6YR4KsfGQrTDWGd7uqiohUXr
         m9tPmd/UdN7eb+vvZxaY+zfhPodusnBTFODv1hBYlZSfUoKujU5WiWetpDCFlOwTG1Lu
         8QTItsgKa4nSkOwt2aUvQZ8XTFmh3XMp3FF22hXlMY65qi+VjTRgyGs1feAyz/yQidzV
         LXKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770300359; x=1770905159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTuYUSmqaG1nhqzwiZ+mkZFjwLolxYQJvYVxP3N4y8w=;
        b=gYYcthU/pflcbIq1gCKFukycQH0ZB6aQM89TyWwNNNd315kg3KuGBwApsHLft1V5k5
         NBYRLFgZ8XIQR1E2qi8Ya0S0q+xoZHTiTwFpvIaDheXqY3XRmVGcEft5GuxEysEv0Nwn
         UJDWmCD4AgA4YIwRn6qx4VYqMGmRF3Vx0slykSx3BtOqFhogDChUvhwIgOegn7yR7qDJ
         mJJWIz60NWv2CRjkobAmWZAtWAYfQ66kLYdDqC8nAqIm9798gUtVuAwdK6SH0Y21YAip
         CirtBo8czGndPSk6Mm1JpnUT+nrwrZzEASbBUOY80emVX1k2EVpJXurJI4psn87+ulkm
         SB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770300359; x=1770905159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTuYUSmqaG1nhqzwiZ+mkZFjwLolxYQJvYVxP3N4y8w=;
        b=jCJ+kF/clFH3klk6oF+cls1wmyjmVnkuV0OjrhZo2gtHUYtRJVhXxMpbAD+bJY61fE
         TU6XmKwmbji64FNKXnYr2j+gR9oQVG5I8THPTrQI1EreVlmxBVLqc4y94fU7OJax8vhx
         KZ5zHbQayFZxVv3rmvAoRceTP9IFO/3IEyL190FVopZFiW/KocspI8Bxzm9T8mMnGKuQ
         h4uyM+F5ZatYGHeaFf19MY2jzwmaLH3xBN5r/LnBbEK/YpDH2wz0lMTgiXtb8zcBekHg
         pG/QVQeSmXuNy/q5gHAGGFyrIoujF9mDlkLW46OiB+EAHUtsiIbF9q3z28a9vpWjQlBK
         jvbw==
X-Gm-Message-State: AOJu0Yw6eITpqyhHhOv3VZPQoLLaAyEK6qCIOx1Gcxl3Pnds1Bj8V3Pr
	yyQ61i95jJWC6Sb17ME3OR7+tiF+NLlqmIttOg7KuTRp5W633gs144Ye1rrHR99RdI4g/eivRsC
	1nWWZRGyDlEO8qXb8JTGqKMMX9s1fE7V0Gp9rXt0=
X-Gm-Gg: AZuq6aJM/oSWWU/7gAVxfVfv4coYnq3O1oeeWOxbZ0S+5bmVQiUYJBST8VwlebqtEOP
	UowLI7+9GGxsVolmX42hiZ8DXOHh/JXbe90zWo94RQCLdX0U7p3DiRp7cT1A0LgCfurHEcE7P9q
	ufmO4Tsu4Y045qm4FQ/lJutPxXvS3XrHNKcZCCOJIj2ZbhXYMSVbilBIpOisYY4Xrwp1Culio1P
	BaO1dFAaA5/+4B9qCwvpm1v0dsJ1A8XC2t7mMgS7QBKRBHcaqHfJIwdoVo29CC96PJnhDwNLEIc
	qIhJSu8vFaSk/B7+m5TEK/YoOHDPD4ylf6BhCbftWpwxAIaN5Fw/t1MLFGpvWQ==
X-Received: by 2002:a53:c988:0:b0:647:108c:141 with SMTP id
 956f58d0204a3-649db48fe4amr4256512d50.56.1770300359115; Thu, 05 Feb 2026
 06:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204133636.29361-1-spencercw@gmail.com> <ca0c3d9c-eb09-4415-9fa9-b5ba274bd04d@web.de>
In-Reply-To: <ca0c3d9c-eb09-4415-9fa9-b5ba274bd04d@web.de>
From: Chris Spencer <spencercw@gmail.com>
Date: Thu, 5 Feb 2026 14:05:48 +0000
X-Gm-Features: AZwV_QiZNhW-V_rPN7iDA6epUMDqTvILO3_r6d8rBFf3GHCT3oMa6eiIGutiH0c
Message-ID: <CAGUNXRQUuWiSJuqAmW6exdfR0R4WUoGJNDoNk3Om+tBN7uy-0w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: bme680: Fix measurement wait duration calculation
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Vasileios Amoiridis <vassilisamir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Thu, 5 Feb 2026 at 13:15, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6
> > resulting in a wait time that is too short. This can cause the followin=
g
> > 'device measurement cycle incomplete' check to occasionally fail.
>
> * Were any source code analysis tools involved here?

No. I identified this issue myself while investigating the
aforementioned 'device measurement cycle incomplete' error by manually
comparing the kernel implementation against the linked Bosch
implementation.

> * See also once more:
>   + https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.19-rc8#n94

Can you please clarify what is wrong with the commit message? I have
used the imperative mood in the subject, but the rest of the message
is simply background information. How would you suggest rewording
this?

>   + https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/stable-kernel-rules.rst?h=3Dv6.19-rc8#n34

Ok I will CC stable in the next revision.

Thanks,
Chris
