Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CD35C68C
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789810556; cv=none; b=uVip7K2fhS0M3p9UkMVtUTvq+QinOKfepKlK5b3W9krZmuuy+EsLm5Jq0zkczURHFd9XtUW4Rda/1ABS9ybIXtqGM/tjG0XBo1ZfxdTeqnJ85JsD1O1wUSgC54h3uwVeUEiBJ4We7mfI6D6exyNPYOOM7AFCwZg82yls0c8ND8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789810556; c=relaxed/simple;
	bh=N+beul/FImQkyb7h536R/T0wdkVs+5g8cR1NWrkcOHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTKfhUgtJZGmHyT025dAxNMSaPDm9D6FLtw4m0lx5yXHzEcVxz4Nv9+bxDANLfy8788NFfY+BOnt+KgpCfBI5BLiq14yVfcwU8T711xvEu9kRfuvVJgKnafuAcqgUa96UVH9KxMTLhnzi3kKFZTXmHtpaqjT3/us4jh0GBojYqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdoQfJp8; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdoQfJp8"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so847694f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789810553; x=1790415353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XkJQmq3NUiwUHSJW96mGCOeJIk1WWq2EDdTDyqhV+bY=;
        b=NdoQfJp8HIHqrijigqEU2c7g4+AAMucwXsgGRaL3cDvtisUrcnfLk+kDmuhgYJ7KiH
         Sd3LeZnvGV0yycQVS0sbZzUuvTaxE62T63tVfcEMSPlSpqhj7MByeL9ygE9WC2907zOD
         AXBbXlaCQQ8C04dDPR3HsZYP3wIcuKY/spNTrRZ1asfw3eT+l2eIjDbVP+I5OrhzCCPP
         eHZFW0UWEJeKq+QMSbXYEEM1J3EU+K8oPx4Zk/w5jX9OmEMxG5zb+yc02UvfPY/W88bP
         3PAGMlwVXhsQEm6XWQs6ipNgi1Kl9qqEtUw6jzOVvQax1BMAaGI+WF0hU6hqYKd70cV5
         tKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789810553; x=1790415353;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkJQmq3NUiwUHSJW96mGCOeJIk1WWq2EDdTDyqhV+bY=;
        b=0bEtTsiV5y49+Jy1tsSGWu3jEVb02olpKrnovtAmMkw4O5TC37EeSXdxyB9ZpHy01/
         vI1DCtQEZaayuIiUt/1yAFcjaMQlHCidAhJoFtRnv3UJDPM60M8wXrQt6feYWmKzkqeT
         uCfTZ6M+t/qioC6rs+qvjL03zgsasSXQc0YNb8VkiVNnMpWBaNP413xXsbDgUKSA3/KP
         gdJWdDW2eWCTZFSb4HlGyMZvTAAu5u47XVkcM/KTUpb4p+iMbGGO2PUV8/39ZwbgGAFD
         KyaexHmdZUsCOcmbf2FfXEFhpjZ2oy0psQgK5qaiiNFakNi4dJzkjUNMasQ+JBdCdsLp
         fHGw==
X-Forwarded-Encrypted: i=1; AKwUvBzQRra0wftydkHt07EsbTnOdsWhbMUi3yybqUf/QAekgkWklJ7EdXuIkAiDyESOKwAcETIspcHWrXY=@vger.kernel.org
X-Gm-Message-State: AFuF++lBIkg7gDLj21oEkTc1QV1MN1fj/F5YE5BRvzrHM3FzPOQnUK65
	IRZq1XyTFzMDj1AGq4fbh0NWpASWGhp3ekbZSS2sjsgi901/8MmVzK10
X-Gm-Gg: AYBFou0gnx/FWrH6K4Yd0xFr9q4QrbIKyuojgUSwJVvxi548JC9seHSjk08VVa1OTK4
	LifD6crxhQrhCjNIWH+BIdFrD7l4zxtN7xhNucEbaojgv6d4KDx+9wU5lU5cOWT3UKRt/6lXWD4
	TX4Pz1ilOQEp+Ch2ybgzR7aN3eU29b75SEBmcN2eIoK9LTtcGXJ5s+OC1Gp+K9zW2w8xrwiYJPi
	1sWmgNX32dD55ZRisS5uFkx++jKr3GQeiHjxcxd+tH+mH96spRFptJzvFJoeeTdiGpURsDjIOih
	kINjIajTNT9FORqYkn6GzKw/wQtHUFZWLIVGXrs4dh4CdCPlJe99c5E3LlMyT30hIA46JKAB5nR
	h6ODY62goY+IiJrVPBeBqk1PcTXvdINrJmeFgSUqfzk3W0U613pHvLDB5LTwl/dn+F/aX/WXjy8
	gBxMJXM4QU5wkbcudG9qWzQ6vbaLTyysKpWO8JLilLbfDWtlh8QUqLQgQN/nW8JnTjNLZ/NYilE
	+p7HLagu1m/qGUUxPocrdsLUNAAZ+DM9eX5FFcpqMnWvK5bL3VJP5QrTfvZTyz+p7LadDAc314K
	Hi5e834nHFtVXYYn/ACQLjmIRfkXCIniJZ5FGVZ5fWtOUqKAHYZZgAfbm6vjGdI61LJtGkitmYy
	Ar8Exnhb/KvbOgbOt4wr+1U6P/GZnO+gK
X-Received: by 2002:adf:e185:0:b0:487:27f6:a4e0 with SMTP id ffacd0b85a97d-48727f6a66amr1041106f8f.48.1789810553130;
        Sat, 19 Sep 2026 02:35:53 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724595289sm5866056f8f.29.2026.09.19.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:35:53 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:35:46 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org, nuno.sa@analog.com
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260919113546.51a943e6@systembl0wer>
In-Reply-To: <a77309b9-7317-4d74-9593-a1f9705ccea1@kernel.org>
References: <20260817111825.000063f6@gmail.com>
	<cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
	<20260818090652.000020bc@gmail.com>
	<a77309b9-7317-4d74-9593-a1f9705ccea1@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 10:38:13 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 18/08/2026 09:06, Joshua Crofts wrote:
> > On Mon, 17 Aug 2026 19:31:45 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 8/17/26 4:18 AM, Joshua Crofts wrote:  
> >>> Hi all,
> >>>
> >>> I was browsing lore and checked out the ksummit mailing list, where the
> >>> topic about guiding new contributors arose [1]. New contributors tend to
> >>> make the same mistakes when sending patches, causing reviewers to point
> >>> these out all the time over and over again. For IIO, this is definitely the  
> 
> New contributors do the same mistakes because they do not read existing
> documentation, thus one more documentation won't solve it.
> 
> >>> case (I myself send an email telling people not to send a v2 in reply to a
> >>> v1 several times a week). Other subsystems have a "Maintainer entry profile"
> >>> that contains subsystem-specific process info (DAMON for example [2]) and 
> >>> (sometimes even [3]) a document describing the code style of the subsystem
> >>> (this would be a great place where to mention things like not using
> >>> kernel.h in new drivers etc.). I'm happy to create both of the documents
> >>> but it's always great to hear other people's ideas!     
> >>
> >> I think there are plenty of new contributor (to the kernel) guides out there.
> >> People just don't read them. So I don't think we need another. Nothing wrong
> >> with trying to make the existing guides more clear/easy to understand though.
> >>
> >> A subsystem doc that has our code style quirks and idioms would be helpful
> >> though as I don't think that has every been written down in a single place.
> >> Especially useful now since AI reviewers will read it even if humans don't.  
> > 
> > Yes, but it shouldn't be limited to code style quirks - I highly doubt new
> > contributors develop against the togreg tree of iio.git for example.
> > 
> > I'd propose 2 documents:
> > - entry profile - documenting the review cycle, patchwork, point people over to
> >   Sashiko, relevant git tree etc.  
> 
> Maintainers file already defines git tree. Patchwork as well. Please
> read existing docs first, because it seems you propose to duplicate it
> (including submitting patches and other process documents).
> 
> Subsystem profiles are expected to document things which are done here a
> bit differently or specific subsystem expectations, narrowing general
> kernel process docs.
> 
> 
> > - code style - the TODO is fine for existing problems in the subsystem but doesn't
> >   point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
> >   devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
> >   stuff that appears a lot in patches.  
> 
> You just described standard kernel practice. Don't create documents just
> for sake of creating them.

I'd like you to point me to a doc that says that fallbacks are a thing
and you shouldn't do dev_err_probe() on a bad ID (to name one "quirk").

Otherwise I agree that some of it is repetitive.

-- 
Kind regards,
Joshua Crofts
