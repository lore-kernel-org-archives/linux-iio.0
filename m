Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE124A067;
	Sun, 19 Apr 2026 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776598395; cv=none; b=aZjC3gxr0rlpu3gQMdCP/j7pMlYq0lYCLWZuzZvxIAmcb4Bb3ne/KcAaaFKJ9RUX0WprSQiKR52UDkMVcU0XaCx8R/SCIM7YTCpEd7I5LfYqZuvrP6fRJhVo8YnCpRHtcraZkmGeNBQOaXxiKtoZvP7J0Y9Y473JnRds8fJDPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776598395; c=relaxed/simple;
	bh=Ab17lz/SYmO7qcwXpipLPL/SCQi0X6Ebie0sjtodmkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7TnDhMkK2LTM05d0PSEg6XD8mj7/plZK3u6LOW9ZwswNmGl7f/LrPA9XWZjo7cYVnN8oah8GFN2eIYMcgXP7qA2r6LE0R8ADtIU9PoYcKhyvKzNCdJI5FwZVLrzQyrsvkc1MdOawT9T5oUKDcgQWxLbf97iNrIVNBchYTqiDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMo6JNHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMo6JNHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9160C2BCAF;
	Sun, 19 Apr 2026 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776598395;
	bh=Ab17lz/SYmO7qcwXpipLPL/SCQi0X6Ebie0sjtodmkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LMo6JNHT6E6BVS+a1ycdkJCUBz+PBBlYHsRcPpfkqMsiQT7RR+Z7zzOK8usyNldwl
	 u18fbb05ga+XnLkIs2I5elke7UDobConDSfOrBMAozRdQbJ2qiJWRrGsnYgncKEviG
	 NWfBV4ty+9pm30JRa3617BZNnIrYn0v6UsyCNLYRQZxJYX5PTww0tve8jreEii8ifi
	 xy4VpC0pZDy51Aaw7+s20VpijwXyN9SuSabhb4ZBGRmHMgjAlWeYb8bWCTeGfHvlm0
	 /z4XKIG0HD4OWngOe9h4LXE6oi9Ob9QMJeUo5kYAYExcIrdaNN9p9LUia5YDmdr9u9
	 9GxnwSMhFViNw==
Date: Sun, 19 Apr 2026 12:33:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Md. Mahmudul Hasan Mabud"
 <mdmahmudulhasan1511@gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7816: replace sprintf with
 sysfs_emit
Message-ID: <20260419123306.1e0bb59b@jic23-huawei>
In-Reply-To: <20260419010537.116002-1-m32285159@gmail.com>
References: <20260419010537.116002-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 20:05:37 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> This patch replaces sprintf calls in ad7816.c with sysfs_emit to help
> modernize the driver, ensure bounds checking, and to increase stability.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Hi Maxwell,

There is a more substantial rework of this code undergoing revisions.
https://lore.kernel.org/all/20260331072453.6530-1-mdmahmudulhasan1511@gmail.com/

Both because that's been underway for a little time and because it makes
a wider set of improvements, I'd rather we took that one forwards.
However, as I noted in that thread, the ABI is likely to go away anyway as
part of dragging this driver into a state suitable for moving out of staging.
I don't mind cleaning it up as an intermediate state however as that graduation
from staging may take a while!

Thanks,

Jonathan


