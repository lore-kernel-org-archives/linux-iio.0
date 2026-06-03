Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B372D0622;
	Wed,  3 Jun 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494876; cv=none; b=ihfaeD+e1x36C7DMWcgXvBLlgY9/BNGi+GgwkigMlZiT2audT5GEWzSKUzbrjZlUdWt0kzdau5BQmXTPx5gtiVchIWQebi1o4aQEpIYboNUCfIAz3XwG2nNqnRkhDArBpd/eJ0fQ0t6N4ELC/1B6oOM76z7MYQ2DBMXto8JxLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494876; c=relaxed/simple;
	bh=jZ+3oceo6idkmjn8BRgbfW+9LUzvIxUyvvV9kUVbFLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0SLS47MQV08DHVNWGCh+otJPs16953Pt7P3V6CT6REslpNMRO5lHh8tfy6iU6cbU4sLs2xsdhNekBW8wEs2E8AibNx0/W3WgdEnbxWJ3AHzkdwdFzUOkrp0ORqTPwZNsHFnMi0esGsp9EbK23l4EQcS9VUsy52O17semC7m5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8rP2KjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8rP2KjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6B61F00893;
	Wed,  3 Jun 2026 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494872;
	bh=JJbcZUle3Qy5CpauUEp0M0VVutmEQhaWJXF/ZN4LlYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R8rP2KjDx+XSXNkMJgBy7jcJ8eAjbC5JlS9xeABFz3hx/2cKYLZTp7hm3V0LYe745
	 EPMN1WuMjWbBJDnzg/qQ2b8U2Pf+51aVzHIYhFvY2mt4wXmvNo8UiSJNZoeMpIkzyG
	 H4wO2o/vI0SfsiClUHY/zSxSE492gTIyWuYwDBPHqvb5KKY7FYUd5ekWC3+PhNnRCM
	 4AJCeH9A6n91cQfBgCwM5psP+uzsWuk6d/9Yga6UVrxqZyWmjXt8bwXHeSrM+vdTDz
	 nO4eqXTIxZscBauqVJrMmft2Nh0S4mgpJ5LNb8nVmQJh7meSs963PG8JlY4F6DsgFs
	 pgYbET/GP0cIQ==
Date: Wed, 3 Jun 2026 14:54:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v6] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <20260603145426.105609c1@jic23-huawei>
In-Reply-To: <20260531233828.60697-1-m32285159@gmail.com>
References: <20260531233828.60697-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 18:38:28 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
> 
> Add new helper function scd30_trigger_handler_helper() containing
> the critical section for scd30_trigger_handler().
> 
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Applied. Thanks,

J
