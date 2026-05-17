Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E421F16B;
	Sun, 17 May 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022252; cv=none; b=RIveVYTNiEFhYp3HrxkEn/EsUlQ0qQjAlrYp2mXl9thrOJWMAnQToHzgmwE02KSB3EG/gDwvKVjh4pfEKt18Jo3VCc/oRhnwQ80ikqtGCsE+qdgfj9AGjDuKDl+G/ZY4W+tbKDj8cEpn7nqbxpbpfpxqbDsLGWoxcvt16zbB3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022252; c=relaxed/simple;
	bh=qp+k370r5qxLtwzQl2NWvvTxtMqmTenuuEY0jvui9z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNl4XkVw/xy+LzYXChqfu3Pu4/6E/CJAvNcvW2ZQy8qHK6si/8AbFln+Au63hj/o+BRTQLfWWqFB/HAmMjA0SiAD1xESLvPMo/3ch+3g/5DB67iGsomPUYRDl2/D9qVP3XuTIALz9KcU4Un7aR/jJ1DGxoUQRmd+jGBNhCjDywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4hIq731; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4hIq731"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3087C2BCB0;
	Sun, 17 May 2026 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779022251;
	bh=qp+k370r5qxLtwzQl2NWvvTxtMqmTenuuEY0jvui9z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o4hIq731ECvV7GStPAh0Orj02aD7o/FHyUnUFoM7zxWjCWkpT0gbR9PfMrNCdS1RT
	 EhQf+1ihbkXJge8I1GQbkm3OQ9BkA8QZ5L8t75YqdEw+zFC6L3d5drl+uZnHnZlcgH
	 tiOlpmuTox0dbyoPOxUNcJ2wHIdxufYKSqFnkvahTLrBxXNCpE8M1ojmHyH7p8D86r
	 mzuYnsTyUeKO4+dcI1e+LBE6i1367E4W7tVBU8S5MES0NilGlFlLvhgw+/Bye7iuey
	 UzoQY/eN/CLNv/CpCvQy5SFRGBjznZB3gm/0MEfTedl1JY9UGtgZwq0mtapGX5ywOg
	 BssQr5X5VKK6w==
Date: Sun, 17 May 2026 13:50:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
 kyungmin.park@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] iio: ssp_sensors: driver fixes, refactor and
 cleanup
Message-ID: <20260517135041.01b43cca@jic23-huawei>
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 23:10:05 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This patch series improves resource cleanup and error handling in the
> SSP IIO SPI driver by adopting the recently introduced cleanup
> helpers.
> 
> The changes focus on making probe/remove paths more robust and easier
> to reason about by reducing manual unwind logic and ensuring that locks
> and dynamically allocated resources are released consistently across
> all exit paths.

Hi Sanjay,

Whilst I would encourage you to look at what sashiko came up with, IIRC
a lot of what it found is unrelated to the work in this series.
https://sashiko.dev/#/patchset/20260515174017.3962168-1-sanjayembedded%40gmail.com

My main concern here is that some of the changes are what I'd consider
non trivial so I think this needs some testing.  Are you doing that
or is this just compile tested?  Given we have a lot of new contributors
recently I'm not sure who is solving their own problems and who is looking
to help out with modernisation of old code and doesn't have hardware.

If you can't test, can any of the samsung folk help?
I have no idea if this device is present in modern chips or is just
there for legacy.

Jonathan

