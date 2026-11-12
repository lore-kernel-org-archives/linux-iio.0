Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501880;
	b=1YhcrGBAmjxECssgo9S9GvHfCuwhlS3vpZkv4QrdONiPdoBDw/6Y2swYFlCCd6huKh1E
	 sjGreRUhmyk5asU2j7sGSOEbbIuoxOaIDzWBxbAeITCLaXup21LEWUU7WSZptGLEwKGvB
	 0Qek5zFvnaDgOm6RVnTpih4TYNuMvJCN9gl9J1TJwTYCi3IPVaTq4usTf6uRdGYWZnNPJ
	 IRGEyMoV9mBPMwKw2YEh+nnFln+W/oCZsxmheBumg/tmx8s5KHjxkxBJdcIq+4vIev+PJ
	 IfSJqoXe+7F++gAFwh1XEjkoPead9ZFyOvzQPmRj1cccEtoSSm3whlNSInwhlO9YjFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=L0I0n48oV5o7BRj/oH4f6pc2kqveIFdpMiqQByS78r4=;
	b=B/Ce5FhgcdjbAlloUptozm5k9yIfVFBLBGKkQ+sWRHkV6IwZUgUxiG3JZln6ynyw53Fj
	 gqA8oIjL+dALzWkQI+JuORDUwroi67ZphD4IKdcKNhpHZ4kV4dTK0AUpaNBPdeZ5fXrmG
	 ty2OXp9FxskETQr91BUSVl7fM+RiRo2LLZp6oB3B9Xm8166tiVKkz36crrfuL/WtSFWib
	 v2ljri0DmOSuZrTlQLNa7Xj9k0uplxySBVzEcgma4ABSpgG2qBFinyKuWQSQ9hRmB9qUe
	 1VvNDaKfTnxST5dfYEDAJDTxiuu2VGCjIh98Vwsl1QlZjIpEK83ua+QltLzzP1lJwNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SuIlegSD;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC3606A323
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 16:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62EC3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SuIlegSD
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so155149eec.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794501879; x=1795106679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0I0n48oV5o7BRj/oH4f6pc2kqveIFdpMiqQByS78r4=;
        b=SuIlegSDTiqLxvrjbgM1Q95iPFjnvtJm1AHCpbYH/Aa1M6ec3/6OeF0Inudj0wOHYZ
         yZ7mAckhOQmOJVRTYUhe2ll5Ca8hBUUGL8CDuNM+jE2if7teqm7z7i2a60bjAqE65pzp
         K1mWu1/+QywHczH0apEZY2OsitrAMzx8FfRoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501879; x=1795106679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L0I0n48oV5o7BRj/oH4f6pc2kqveIFdpMiqQByS78r4=;
        b=HUxh1Vk+vbgm7CxJoHMn3VF2E/HG6tcryMUhA6CKPfMH4Jag3YO3PeZuW5SvmI+Lo5
         UarQD0lNEqzO1g9rY/RBsC6gON9CFxFcYfiBrOui1GnY9ulqnxgwmnD3Kwyf9y4sT6SY
         b/+0vhh5D0Vv6A84Ok18y4wnFOZRoNOmZvX1wW9SlEStCgfPaJILruCSuT+dMgtfO+P7
         U0mX/Tlx/FvYRIrwJdk+6J5f0jQIJ/7ewLZLHNmD66NPm9tC5vjJYgimiZ5gvke4d/53
         LtxEhzbLjuzY9pjFq+nNvNQNyAxKJHO5Wh4yFeFPDutyRePDfJb20JdS5eHcJaSI+GIz
         X6tw==
X-Forwarded-Encrypted: i=1; AL+hErHpLjHdh9xjA+y5RYzRANmUPusR8ZCpEHemj8HzqpAOdCiOG8MTCppdcm5BLcEQkKIOmh3GOor+B/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qT71X6H2UxaJtSbL8q/uZnndP3ehjfM6uMOGsUFmyMJ8IJw33
	aw81hPd8Et6a34RGuYfFoaeOOipn5EnaQ7H1CNFJfRTjcX6TwH68C+jZEJpyTcO5mw==
X-Gm-Gg: AYBFou2BVhwS561WUgxh4j/vFL6D1JivY7dsQLNR6CnSfNnVVWcuNHGiFpBzuBwH9ox
	k1K+lEM4SV6fuy3/1PQlaAutTlluNL8ugvz7Xg743Noa0ryWVjxLV7gq09hihT1PP2ACttQ9Zjk
	PtQqkm+GA47h/vIe34BBHOYNHRlEG874wlaLxMWGwewv9EataVyZW9Tte5NnFVJTqP6ksT4c9Lb
	j7hwnAW8dc+VB967VKm9dQUoCO73sZnoNJO7Gbm3Q/L2R8wSR4+59KY/Byxw59p5xKLb2Azvf07
	8bH3eWKNPtiOgVFVdodfpiJ8W2F5zdZwCAB3K8SP7Upnp0rG5Y0Hfwmlg11gWVi6jAtyHjWs5aq
	enn1XnMPIUSNnlvmzCMrsNlpi31IFV3rKf49Z/2xQhC0KwNl9k7xAXcBbPtfNoRpYCobcZ/RSX4
	uusDrPu0IxY+cxaKjXLSqDcUqOOyKio+gaX0bLx3k270R9BvntT/0mosZIDlVxwkdq3pM+gbDPo
	1+DdXA6LDwZgBDB2odSy42VcvPmfqrJAlmDW+88zMb6gdi77fgkrk7Pm1DXDVQDoXovN3P0ElpY
	jsaIfZ2E15YdGBTtCr2WZKdREN1SEU/gf71xvfLuFHRmijcJLLVomvtHMIHYryXXjxw+
X-Received: by 2002:a05:701b:4551:20b0:194:3a84:e67d with SMTP id a92af1059eb24-1b5031b37dcmr81202c88.44.1794501879423;
        Thu, 12 Nov 2026 08:44:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5031b2519sm137097c88.13.2026.11.12.08.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 08:44:37 -0800 (PST)
Date: Thu, 12 Nov 2026 08:44:35 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <avXs826ikSctpUnA@google.com>
References: <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com>
 <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
 <avOw_4ZkqtKFHu1B@google.com>
 <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>
 <avSa97F1Nu1LTSCA@google.com>
 <fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu>
 <avUHG8mLuTOUMr8O@google.com>
 <CAJZ5v0j+8_fOc_EEGx4tquqcaH3-nmHd0YMJRb38t2Rw40iV3g@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j+8_fOc_EEGx4tquqcaH3-nmHd0YMJRb38t2Rw40iV3g@mail.gmail.com>

On Thu, Nov 12, 2026 at 05:13:09PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Thu, Nov 12, 2026 at 1:24 AM Brian Norris <briannorris@chromium.org> wrote:
> > I'll give this some time in case Rafael had any other thoughts/replies,
> > but unless something major changes, I'll plan to write/test/submit v3
> > where rpm_idle() calls pm_runtime_mark_last_busy() (part of Rafael's
> > proposal), and *not* make it conditional (i.e., no
> > pm_runtime_use_autosuspend_always()).
> 
> That will work for me.
> 
> > (Or, Rafael is free to do so, since it's his idea. Just let me know so I
> > don't waste my time on it. But I figure he'd rather someone else do the
> > work.)
> 
> I can cut that patch.  It is going to be a one-liner if I'm not
> mistaken and I'd like to write a changelog for it.

OK.

There's potentially quite a bit of follow-up, including patch 5 of this
series (to drop now-redundant .runtime_idle() callbacks), but I can roll
that separately if you'd like. (Would you want to make an immutable
branch for other subsystems to pick the 1-liner up? Or just apply such
patches to your tree, as it seems the IIO maintainer was probably OK
with that?)

I also feel like there's probably room for unit tests in this area, but
again, I can do that separately if they still seem valuable.

> After that patch though, using pm_runtime_mark_last_busy() elsewhere
> will be mostly redundant except for pm_runtime_*_autosuspend().  Since
> all of them call pm_runtime_mark_last_busy() (AFAICS), it looks like
> last_busy can be updated directly in rpm_suspend() when RPM_AUTO is
> passed to it, but if so, rpm_suspend() can simply set the autosuspend
> timer unless it is already running and so last_busy can be eliminated
> entirely.  I guess that should be done too (in follow-up patches)?

__pm_runtime_put_autosuspend() still sticks out, but it's nearly gone.
Its only user is just re-implementinng pm_runtime_put_autosuspend(), so
obviously it doesn't actually make a difference. I've been waiting for
someone to finish this patch...
https://lore.kernel.org/all/20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com/

So I think you may be correct.

> Moreover, after all of that the difference between pm_runtime_put()
> and pm_runtime_put_autosuspend() will become somewhat academic, so is
> the difference worth retaining?  Or can we just say "If you set the
> autosuspend delay, all async suspends will be deferred" and drop the
> "autosuspend" variant?.

That's my preference. I think having so many put() variants hurts a lot
more than it helps, and especially so if the differences are nearly
nonexistent.

> I also have to say that I agree with your remarks regarding the
> .runtime_idle() callback.  I don't think it has ever been particularly
> useful and life without it would have been simpler.  I'd be happy to
> just get rid of it at one point.

Great! If a few other things settle, and I find that I'm able to clean
up my existing patches to my liking, then I hope to submit such patches
at a later time.

Brian
