Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339B381EBD
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813405; cv=none; b=Cde9zXJHHGNUrAmTTdvuPh2I4djqVsVZ5GNENw36GbAw5dbqYY6WpU/4kVEOPXRuEP9GBdsWZ3k5ltVXQj8s2z9HzfissT6RZGmzGgOb4yG52wsMuAzOFngfrmXt+x5ul/25Mqgm9rAJA7eo42ZsgGvrkAtm/BffdvP2CQbBDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813405; c=relaxed/simple;
	bh=L/9MsltiVxDAB9BNwzkHRMxC3qXxoBU85cZrGQmQAd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTzQ+mVW6Ohnf9I16Xk72gMjfPmBhsIOqQR/iS6wD6gsPV/L7P5uCi3chLdqWL4h//m6O3QFT/8xtoF+8+BDyloOCdd6WWCudJy4OkAnbUsLtSovVXKWhl5u9nf80MwRdfhx8Hz5tbLrFP4eovPdIQ6J+eeaX49t84/22d1ZIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsNBgUjr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsNBgUjr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso22591285e9.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813402; x=1792418202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUYoS5AA5l7ySIMcuvHl5B+AVs8QiINi3gGrgQ2SCkU=;
        b=KsNBgUjr8dIYoHTWbojY7qIBnrpg0kRl13ZdWNG0Fr0VMIQ0JVYoJBRrp+0eoSKfZV
         e9swGtSflbmglT39C25kwXvGNRnPvVFJg/qrDu5KZ0bY34rx5CDJMlxgJXdIMFBgRzcY
         iRP6cQ6J+8zHgOIPIkgawqPPInV7bbSfst1jyQ3J4tIqGKnC8Q9564EsQ4WganWd8HKS
         DVuhNKpSiOtZSSUUtpGGHz3ZJ9jggBryczOATAahN80kfSb0W2XpAjXlr9HItM3ZChv5
         pdEX67ih+LOP7ib45xe+dcfu/7Xd/DhTW8b2xmZQgDG//jgNfJY6cOPizcHj13HvEtB5
         fzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813402; x=1792418202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUYoS5AA5l7ySIMcuvHl5B+AVs8QiINi3gGrgQ2SCkU=;
        b=lYAhwnQSTJVgmOJUxlYjnR+G1WDsObsRf9JenfIg6q1xFLfKmcm6ALoQWBBQstBMrV
         vcf3xcbysiwDYnp9KvyRwDribox2y4FKhECJh+DdI1j7MZiOSRetkOBjq2Ekw7Tm+wLV
         kFHotQH7WNHOdotW+ohTUlYG4rsozN04DKLGJO8OcW088JW63ooY+k2yAsp878gUhouH
         0tsQkjOs6LRJSJytjxcWh3j29uX3IlY+uSHmFOoXOqvPUKBYsWqHcbQG0VjZuLdvQZUB
         jTdj6lYjIDjzf7De+iob0oe+XSHjhjRp7MDA9/WViTCntH3ycDbUlo2lwfOJstT3STRv
         QgJw==
X-Gm-Message-State: AFq9FYJZ3EUttO0CIHnMw1UoJeMP/YJdxs2ghY+BgWDooBUkYLLrZD7B
	4Slq9gFL4j4yZgt0kg58fF8Kgs6wC1WX4VMHSqft/viD7gexsyHAI5lo
X-Gm-Gg: AYBFou2D5D7xlrgzmnsaT/PuukubpSN7SUC4m0CqKYjd3ef+jBSCkio+nHKI236aJMD
	ZipTkYbhLcmwDK+83c+Fm/yFelVcCn2XB4X85v5jh5V79eWQ+uwM3EygGhuCZ/f5sKF7pbk/xZ/
	9iXbzS+JvDlS3QTnhZYmKbRPKIpLrnyOpOeTeHUGutt59QlD9BxwF7RgOklgL+wFsFPHrXrFbrW
	SwS04YXPAkgPhnWQV9cDxEoyl6SHQaSIz7iMRKmSZ+gpJr9SXT6wLqxh7ZyxljMjPOALL9GuugY
	Q34bNJe/m8oFSv+Lj48wlxREe6+fU/Q25h+nb9vC56KQn4+C0GP6KbnM6Pt6ZZ3GHsTiXSNrhaP
	9Zod9TkjwC54c62aNCKilEFMih0LNOcu8mom0h+vBD8ExVhJidVi44iVL7rshCEXD92R2JlxX9S
	PRT+IR8q2cxGmrWfqqu3zq+INUj5n9G62DiHMX/LMNKqnIyMbOWGmgZp/nmolVhYlnPqWBB1sQQ
	qk/L72XlKwSAAXEdjrAWzUOZDu0sWm1kErVD9/eJmZ7EpdrIWKjinSo840PcX0inU09TjU455Un
	Zbj7TVkl2OImLH8pi14FRLhuq9vqk9SBMgnTwT2wx0X/OLFG4y+jpATOLwBUiSm5oZcWtFLPiBL
	nnRahDRnKQfiTTEsjjh7IjMuNQJm5LIb5kBOs5DJsAg+Pvjmz2DW1LshXaXBAZ8KS1+0hsJz/eD
	mkk6vq8p1uRPKcRYA=
X-Received: by 2002:a05:600c:19cf:b0:4a0:168f:d962 with SMTP id 5b1f17b1804b1-4a18e44363dmr178450155e9.3.1791813402425;
        Mon, 12 Oct 2026 06:56:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abd574sm20255889f8f.34.2026.10.12.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:56:42 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:56:36 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <20261012155627.00004cbc@gmail.com>
In-Reply-To: <20261012114553.3327-2-nikhilgtr@gmail.com>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
	<20261012114553.3327-2-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 17:15:53 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> The atlas_ezo_read_raw() function rejects channels that are not of
> type IIO_CONCENTRATION, preventing the relative humidity channel
> from reading raw and scale values.
> 
> Remove the early channel type check to allow both concentration
> and relative humidity channels to reach the mask-specific handling.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---

What a weird check...

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Additionally, Sashiko found a potential I2C read issue, please check
it out.

https://sashiko.dev/#/patchset/20261012114553.3327-1-nikhilgtr%40gmail.com

-- 
Kind regards,
Joshua Crofts
