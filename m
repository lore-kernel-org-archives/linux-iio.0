Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389491DE2AD
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778397390; cv=pass; b=F688kv6ENVAwL9nZbOR5WJBzk6jYhFDxcPU2cjfGdOfevkfxlEHCKmjvvkedECbY64iP/0CmxhXZ7ag3VKLX/tONA8ycflbFyDadJaOP19o6vAYpcPcZ5u9bPoUolxidw1iqjC1XEcyuJvab3Dd0xLKLe+haOtmVO/Kg6XS/f9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778397390; c=relaxed/simple;
	bh=gHDivU3MdKNaCJgVsacc/ZmhFlDj8+M89UZqTQuFnFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uasrdCZSXzCYmJ9Hi4SvPHb7fMSK8cuZ5S/V2q+zH3iswOlbJaaLq/SYmitsae1dJ4DhIJPUT12dYYmDR3KJe2Wk6KPckZtucyqrU7x62gV4JiykeYprPHlfKAIShckM3GC8/Yvptod1MeZmJdRLwK8//shZA9Pdmx5jYz6oBlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+zOqpDQ; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+zOqpDQ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651c7ddf514so3590765d50.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778397388; cv=none;
        d=google.com; s=arc-20240605;
        b=inEDtnZFSYHAEc9YRPlRelc8bcKKixeGTYZ/cJxXVxDqVOzg17H6K1Ych+qFHp5kzw
         LLSjQhh3tr4XxbzABxgC8qaNpBz55MBhhkd7Xp0hocnLuhMR9Q2nZ5vA/3+31PbPyPfZ
         f2ZUXeo98uonzjyjwEgcV80chWHxHsVLi1n0rj/jauotM2HvnYt5PJqmQMJmrZC4z6v/
         hcFEGZkoWYDOV2idaKHHUTgyZX/Wi10D0X3ZF2vJ5r66Mk+TJX3/ewuYC/RU94dL6FKl
         awMQ+y1uWmJkTKuEKamTRTUR8nak5PxHHf+i8X+0Phhw9oy42G1VKs8c0OvrcW+WknmL
         O2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHDivU3MdKNaCJgVsacc/ZmhFlDj8+M89UZqTQuFnFY=;
        fh=rsG++t4TFSPYBnDKQquA4P8x3mDghc0+mmGy80Gp74A=;
        b=QlOuizUmjRr9RG6+MnokuvAM9UBF/iw836H7m8ArcIwTLYvVOf4wGGRLk2s6Sp1e3n
         vxyL2mIAlR0ywGqH6oI6QdDmWrniYA6NnJUj3nrI7gGmiNpPOLgOvmy9nsCB3Q63C01t
         FLRG6OgMHH61nVfiIAtWh6+LnzwHBjDiSxSWQOJq4aDcQllssfOzUpJ+qkX1lklvq7tB
         lZqSFquNCCcShpq7R0qpiHJbr8EDjFB0PbOXVtbeK2NAvX+9N9jgAsOoAtlU2mmmWlCd
         dz1Ox26PMzKW/bCG1Nfl0yDn4yUsy9cNFObbNu1j9+CEbZJeGj1rbgzzZna93AhpSzLZ
         EukA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778397388; x=1779002188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHDivU3MdKNaCJgVsacc/ZmhFlDj8+M89UZqTQuFnFY=;
        b=l+zOqpDQiMntJ8gqL43pOJ6SXQjf9OOEjLVkbH8HsQiP5T2jAdDMOHILbJuAwi8YLP
         bjTwDA3SVRaF4Oa6x89C8ryNSaoNUVnBRK6ugdTx7jd0ORCss/3gH9I3GIhuFYu3xZPw
         HmsKr1dLe2MqkwF0HFH/tiIexUQHOzMQChs0LWIP0Oleah65m3c8d69q9h4F43LyCIlg
         NaQQNEqW8ymsS4wdUoURM5mFKGwtjPJltXHklL+upUQ7xwEBFs3pNPcSlg1UNisHbyNQ
         tu3Sot1JFjbAHxtrYRr99J28ZSvFepqZaNvey23jkFbTWhSEbReFyMHuU4IGIpexE20j
         nvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778397388; x=1779002188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHDivU3MdKNaCJgVsacc/ZmhFlDj8+M89UZqTQuFnFY=;
        b=ZDHLgj+de6lvYaF9jvWobJ99pGN2uRVIGiYztXSwNv1DDsOymeInYnCpwcvnx/odpa
         cjWsqz97/MX5V2OBho4mb8UkrHywp1shiZPUGluB8uplCQP+9Y/ZOMnwnp+dNTq2gnQk
         nS2CWojKJjy8UMrvVkodnNyVoU0lW/3YXq8dvrzIyYcc5QUsdmeDs90RlOPV2CQIqHED
         LzX1Z/IaqlMd8WxZnFgR9VjhGxrV765a8Zhi1bQV4B85o39uiKnoiILRb00ak7de9tm1
         vGtHet0Mye+7xfd2XF+pGBoBRsnw3vhi2iNwpmUoWwKqxEkYbE0rJ4ICGrq0UKCQGqO4
         iU5g==
X-Forwarded-Encrypted: i=1; AFNElJ9YTTOapJjKzCPhZkthABx1gLjxXIjog5YZW0P07k8GFfgC9aivCbkeEyIuUue0m0Pr1gv3CqjvBzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFW8aHJpBX5c8IV8Mto4yfKyjKv9bno650BLXC7+m3ygb6l8aN
	BEvPIA10yhk9jl871TVckfcZO4dZL9sHXM/lbBZnyRxDJbDhFJFf7oFHMYt+ryGYk619rBx7/FM
	SHgR7aytculux5RmlGU9wKVODo9fiP7I=
X-Gm-Gg: Acq92OEQi38G5HvyeXWQML4gVRc+kJ7QvyC3m10k1cM6pC3sRSKMd5pWtCKc3otM8DQ
	6fvKsHEY+3/F6h6qinoI5cZ3FX7HpB260LUtdgqHcAnBNKAoJsywvZM8A2/qc1nJdToLJeXhD67
	MS8SOjJqnrWEzA7P7av75dRX8yHE7ZJ6O0noyWeEmMJNalVH4m6AKD/uaTk/uwPt6Wui8CQYaij
	KP6pYyZvNr3qXp3X4AENWhV46mFFduno6Wl9TVzOb3lUXE1KW6EvahMuJqp8D+O7t4zaRCBAqLO
	o4+HtKI/ToNO3C4=
X-Received: by 2002:a05:690c:c504:b0:7bd:8cb2:4fa1 with SMTP id
 00721157ae682-7bdf5d98fd6mr205966717b3.5.1778397388171; Sun, 10 May 2026
 00:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
 <agAvydze87mMLaVC@ashevche-desk.local>
In-Reply-To: <agAvydze87mMLaVC@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 02:16:17 -0500
X-Gm-Features: AVHnY4KNsbPTHpmymyOCwaYYdix4H0QY2Cq3Ah3hsHITb0R-21zm2rQ_5OBGeqM
Message-ID: <CAKqfh0GVuEPRK5mZ2odRF4pwY55_7F5=xsrj6NOUp8zXgVo5vg@mail.gmail.com>
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	tduszyns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 2:12=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, May 09, 2026 at 07:14:35PM -0500, Maxwell Doose wrote:
>
> > I was preparing some other patches for the sps30 and scd30 and
> > realized that Tomasz Duszynski (whom we've already considered
> > inactive) is still listed as maintainer of the sps30 and some other
> > drivers under a different email. I sent a patch for the sps30 and
> > while his email didn't bounce, I still have reason to believe he's
> > inactive as according to git log --author=3D"Tomasz Duszynski", he
> > hasn't had a commit in a little over 3 years, which means the drivers
> > he's maintaining are essentially orphans. I'd be willing to maintain
> > them but I just wanted your input before we consider anything.
>
> If email is not bouncing, let give him time to response. If there is no
> response in a reasonable time (usually up to month in the summer time
> due to people usually have long vacations), then we can act accordingly.
>

Of course, sounds good. Just wanted to follow up since Jonathan and I
already determined that his entry for the SCD30 was dead (email
bounced).

best regards,
max



> --
> With Best Regards,
> Andy Shevchenko
>
>
