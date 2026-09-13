Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6E27AC31;
	Sun, 13 Sep 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335366; cv=none; b=OqIPeePfcf51NLriuoPRQZks50A/8OKmweC30QrPtXP3vsFDKcp7tNCh8u9pYZKh3MmVR88SmNpzc59y0gDvRA9CMganua8uY5QvaUV1VNogQAxHovOaF3pUoJq9vRK/jZq7QzJGDrOpj/25qJ3pDplq6Se9+++354PN7AzEFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335366; c=relaxed/simple;
	bh=wfBxIlyZFdJesp37kdfQkdBw6lC9u2iFd9MD7VVg77U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqzBTd7f9bV8Boa5QHtfcLfkU5hdCI86yP7Bhzfk/tD0gtZ3RvRgDlKQ1bZPeWQKOfxCjNdOgB7MRnDdBMUML6IH1sYnBMmIwK0mBMulaLcSfJzIbVefem8IQ4ktHol/AtFnScEt/AfUG1hBTKDOlY2xDgLqlrRiquV4oZhx08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+KbhuFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+KbhuFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A8B1F000FF;
	Sun, 13 Sep 2026 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789335365;
	bh=G1Js9//BeLuE9hP/9FqaTGqM9Di5NadEVmxH1VEV4RQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D+KbhuFIT9UDjsHUEhcQseIAyTW10T0ckHV5BN+I0e0O+0ajZLnBoOjq/9pdY1JJk
	 M8w8/3mrQQ9wih31asgCaM7RLlVp/ga0ZPuPLpUMydyFo6tYsKAth0TPxO6qFzTP5m
	 DthxPMLbNdKG6C/yH9oCilS5xDdOW4VZD7dPF1Z7OumF2thaED15HCDzlcJaaRcq45
	 HNf1B+yMddd6MT04pmtZOnBdI1IvUHQ6/4dKWDdhLTTZJKu1Hp+IGbydPdnRjEbaY/
	 Z/lHgksuDrmOJwGJkiXebA30FLIEYVBt4wF1Z2JeClLR7aAslaXn0e+3TUhevxxODP
	 GrfYVwP6heqKQ==
Date: Sun, 13 Sep 2026 22:35:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com,
 julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 0/5] iio: add Open Sensor Fusion UART support
Message-ID: <20260913223558.62ef475b@jic23-hlaptop>
In-Reply-To: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> Protocol specification remains an open review question. The accessible
> historical protocol-v0 drafts at OSF revision
> 11d11eb413e6a0e861e4d45fdccadc71c5f15c48 disagree on reserved fields,
> trailing extensions and magnetometer units. They do not establish a
> versioned normative specification for this implementation. The driver
> requires exact known payload lengths and capability scales in IIO units,
> including gauss for magnetometers. Documentation now makes those
> constraints explicit. This does not establish protocol maturity or
> resolve the request for a canonical compatibility specification; feedback
> on that requirement is still needed before merge.

Please put this statement right at the top of your cover letter.
Probably in shorter form.  "Specification still undergoing review,"

This changes this puts a big external dependency on the patch set
(I'd have preferred this remained an RFC but I know others asked for
 that to change!)

Given limited review capacity I want people to make a decision on whether
they wish to review knowing that the specification is still potentially
in flux.

A such I for one am going to hold off on reviewing new versions until
you post a patch that at the top of the cover letter says.
"Specification is now reviewed and has moved to the stage where we can
 rely on it as being stable + ideally a pointer to an errata process so
 we have a grasp on how specification fixes are handled.

Thanks and good luck getting to that point!

Jonathan
