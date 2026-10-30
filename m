Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360449;
	b=oSI3/QcOQ/A84Xclb00R8iPXXweTdJdZigZ8lYmwRZ3QuUnpbqhjLCbI4d1ELcbgkizC
	 kl8rW8dZfQxt42NDpUltRAHykQSb0rWhn6Uu1ozUwq78EvFm5OUrSmACU/s13MWRUXkmB
	 hPC3zieqbkWUauOQyaviX0G38FuraTToWl6bmCWX1B/4I3tCKQOYbwriVY8wDuBKiml8Y
	 L9GLEjPwPJUQE9wdNtYlXVtyWXHLx+ChvcEW1+ugnFKuZuWcCSrhh8qVdiLCttqlvigA/
	 6T84HkTMccXeYDZoo7Z2Mb2ifOlh7k9NkkcIXi7edXioFX0wUDbfw1AziHIbJp3mHbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360449;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BY90Za/JCHy+xgr2C8pKQUZhNspX1pb5ngLRt4MMhi8=;
	b=L2YAIpZ//9opUwHTT3l7gwIAIAiwDGFrq50V7VXZsHt285oWmlGXUj9ArnWgmAl+3fDP
	 odNFYV/mKxfXyOtHpER4k/PD9f1ZLO0da+hByGh1X7bsCtu5ZggmbmByG25Fc/wfCOMrR
	 pubx7skVoiscEsnJ3Epckpv6F6m/6W9elLUTuMBLlFOkit4G3JuIrKMJgpFvrZPX1/FfC
	 vTcqpgWPVOrxDJyMAGL1oQOpk1GlGWEA9F9QfRFea9v6s9CUSlvtSifGrOgQUOX60YpYX
	 ZT+24KUSy53Q5bAAl5ZCJ+JaFsqTA7y2FUDnKXuQ3UWFztQb7GqilZD/MjFifIwegQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vktc8TjD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B5606A31A;
	Fri, 30 Oct 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vktc8TjD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793360449;
	b=SV+p/5c+DCmM0kN0Vw3ZslL6nwxVKpMnj5QH4iaCmL5mTAWTX1B27IJRUoXlxyc4WYnU
	 teiQA7RmYDch3uqZCIPQOPWBkH2vphZMAiUlCsmmBClsryG+XXWCFC7WY6fKuC0q3zQGx
	 5wo0VwrlnK0wUh8qOkLi0A62cC21t3x8ceXzF6BgaDsMy2kpEWrrxl3oP/IcgS8U2jmAx
	 2hW5Kud/uH1s8iL+DsOynVz9aAG6pEb9YigrI4olBJQ9Me+73jE9kBFy+3wEavBWOAxGf
	 RCPddKHJX99krvD/P0soUAZzGhkyx+1a9BWgIZ3s47jNV3kV99+nMqPTMHOETMXpbFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793360449;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BY90Za/JCHy+xgr2C8pKQUZhNspX1pb5ngLRt4MMhi8=;
	b=bH+5ONxaZt1Ta92dVy63+Mw/QGFAH5nh0nijevpCpXq7/pMpwcconLgIiCmFyveBHgPA
	 AWslbim3Kq73MbYfRCZR65d0HhElpxQLRi2Q2+IkKArq2I7+MB+EOl5uLXhNkoqQc987b
	 rSscNJpfrH2LR1wVEWn9blwA1lQzZcP/Wirj3C2IKlf1fPrV0ZB/Ga5Y6ZbFsB87xDoFj
	 oHuiphF1a+M8dWfU+gMyk9oiDwjTcH1SnWbEjCWVdbJbZbeXjifCk1cHZ5XU6VVKycB+I
	 sPU7nrthCbLlng/htEHam3VlTIGVNwJquEBa/mmkAZneJwbfQ0gxvAkNc+/ICWK8m0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 53C4A1F000C1;
	Fri, 30 Oct 2026 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360449;
	bh=BY90Za/JCHy+xgr2C8pKQUZhNspX1pb5ngLRt4MMhi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vktc8TjDxEXvvagEPCwa7SRqf0iW+QldwX7auFei5/U+B6E8GT293THS66dy5uHBt
	 o7n6qOGVfhUk1te/HFjNokmSD70AIsnFRHCWoWzJkjOcohQWMHLuw0YvbHy1EE3G1F
	 3KUrgPCL4wRhu/O4Fd5FdUeswZAwVJx6sxJSPp2qfqnVSDifkOAhqjjQRKjoKFoAHi
	 g6w8RNI/Pk8fsfYjEYVTIzcbPntuKmMxX8+SM5NO5eI6PUlIFFSPW2xMkF5/2RMs3k
	 KWHRFiQTMzToa89jHUntBwazIfOJAOiTAwB8gmGwiN38Vnvy/OOCj46hSPkkeznhNS
	 1aYwrO2xGW8ng==
Date: Fri, 30 Oct 2026 12:40:40 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno Sa <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux@analog.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: iio: addac: adt7316: explicitly include
 missing headers and sort
Message-ID: <20261030124040.00003db0@kernel.org>
In-Reply-To: <20261030104745.16693-3-abdelnasserhussein11@gmail.com>
References: <20261030104745.16693-1-abdelnasserhussein11@gmail.com>
	<20261030104745.16693-3-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 12:47:45 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Explicitly include <linux/err.h>, <linux/errno.h>, <linux/pm.h>,
> <linux/string.h>, and <linux/types.h> for error handling, error codes,
> EXPORT_GPL_SIMPLE_DEV_PM_OPS(), memcmp(), and fixed-width types. Drop
> unused headers and sort the remaining headers alphabetically.
> 

Better if patch 1 only sorts the list and patch 2 removes kernel.h
and adds/removes headers - it will be more readable that way. Have
a look at this patch series I sent some time ago [1] for reference.

[1] https://lore.kernel.org/all/20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com/

-- 
Kind regards,
Joshua Crofts
