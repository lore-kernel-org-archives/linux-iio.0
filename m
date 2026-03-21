Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76D1A23B1;
	Sat, 21 Mar 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100833; cv=none; b=mWAcAVh/5Utz16aSGFfM/wJnZT3KGEWD2VVliBDNK9zOo7Rfng/iW4VIJPUnrbSNqEepRHXALN3t1lI3QizDODG+dHLogsjrfJm/SMN9yDCUFWw6kkGA+RZBhTGTd2nH0avD/7mdQ/Wql5lo7pFR6OHJ+WL1MTriRlfKwKBSvU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100833; c=relaxed/simple;
	bh=Y3v8+6+CIUBOjXwj8JTkVPaWbi6yxFacxsY4jxsbOdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fak9l4tDFiooHDMcX8oTffLSXm2e18AiWvDT+xx0lBm5vOSVxGezCT0C5NBirArHYMkpHSA5rfEgsfLlze88mCfIKYbr9e3aHNw7o2nlAl9g/S8uB5T2KlC0DBzg0sZQIQKnsM94g6vLmQm+YzaD0hq8fK+WdS1/FwTGj37bqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKhfK2IG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKhfK2IG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B1C19421;
	Sat, 21 Mar 2026 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774100832;
	bh=Y3v8+6+CIUBOjXwj8JTkVPaWbi6yxFacxsY4jxsbOdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKhfK2IG/2KgKQMxb9Zy7GU2oRWY+0jow5v3gs08xP16UtmXzh/e+EWm+V0SzF4N7
	 MH/blR0c05iGtwx5Ali5bzedSPDBHC8L9ReIVs5Mx4q+uEDso6fEewvwPMzBVBmPIW
	 GzlFBS50TNRO5eQiizDe247sNEcGPbz20l7Xj4L234yZi/wP4/AHM21NhAo/y1qIWW
	 Ny8Ul+7kvRUbosm+dosZYSJAN+4bjKD/3ZaEs289kd6G3LK4jTlfAQ5eEiqmNfjwAP
	 UMUhLA8GJrewNfWXcYjGhH4F2+jKCAt+CSMpzXGEzpqBkURl+7eqCzFzlqsfqN5bkF
	 edGH+0AStGTEQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: sysfs: remove double return in counter_sysfs_attr_add()
Date: Sat, 21 Mar 2026 22:47:06 +0900
Message-ID: <177410076330.147693.10667697785963184882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204180032.514328-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260204180032.514328-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=610; i=wbg@kernel.org; h=from:subject:message-id; bh=oYZov6cjB8QHtGHoWlm+AhoDNOJzOefRACF6N1+K6Go=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJn7FqpfzuwwFX84+Yrz5pQPjybfU+7Y+nzanDrGIxNz3 Vau3JLwsqOUhUGMi0FWTJGl1/zs3QeXVDV+vJi/DWYOKxPIEAYuTgGYyIJZDP8zOoVe3XattPzV 9uC1V0BE9FurZq3JmpP/spfzCc/c2H+S4Z9e9Oz9p/ns8j/p9oTeKL9lU+C8aYnVtOgo/V7D60u kLrMDAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Wed, 04 Feb 2026 20:00:32 +0200, Cosmin Tanislav wrote:
> sysfs attribute creation for counter extensions has been consolidated
> into a single function, counter_sysfs_exts_add().
> 
> Inside counter_sysfs_attr_add(), although the code was changed to return
> the result of counter_sysfs_exts_add(), an unreachable return 0;
> statement was left at the end of the function.
> 
> [...]

Applied, thanks!

[1/1] counter: sysfs: remove double return in counter_sysfs_attr_add()
      commit: cbf8db23fc58db8d516ebc7aa57c4563f36532b9

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
