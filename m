Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7192D97B9;
	Sat, 21 Mar 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120418; cv=none; b=ZVQJk9Dhs0R00SyLDXMa9CkLfypkI14K4h/qigjXOhoYQA8o3EkFLlATWj3sarxCa6lhL/ExFHBtvk2zbw1o1Ay1T08c1YAjxD0Bj+8oWSDFceDnz8H732R8NZPZdtxFz11fww0zXm77tJhDFUp/W+kOS9hLMHNUvHjksHZVyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120418; c=relaxed/simple;
	bh=aOACICWiJV/ZkR6pkn62VpkXoxiOSAGz7sK9sZ+kwqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPSsrStspt/snYgIPrMZ8VSS391/zPG5lQ76CBSk0LZ8hyByp1yuDk0QnJZ/Uk9AMc4ZkblqEf1Po5i4rAq6CIyEtDVy6TX/KHAdUIWiRY3N+LzED6A3VJ79sPnWemTI447DYKehCxZ9aO9se+IKNS2ObjPRiZUPLX8KYLnOydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuJOMJpN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuJOMJpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FD6C2BC87;
	Sat, 21 Mar 2026 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120418;
	bh=aOACICWiJV/ZkR6pkn62VpkXoxiOSAGz7sK9sZ+kwqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GuJOMJpNbychJC22tFuILc0TxiQa6NEInrEKMYwvKW+OAn6ZBqoay6AAMBhgHX0/5
	 kMK7A6Q4MfUwcFOqG8kfVIoW6d4pJECzi76Bz0f2UreZTBevkMkfgPatEh+aGEIHwT
	 xo4PCkMeFRfH1j+bLbZGDaJEzESM0hgpQj0u9dChQ8zWv2y4sCR7wKVASz4gUXO3ZU
	 v5WSVye0XJBORa1cVgLi+ylZCNXyBmvo9DvB4ZWTJviNRwbf/itRe05LA+CwmplJYb
	 Gk76JKscZ6NOCk4mIIyBRWnN+ZJyxEalOXw7ojQMsIDquDlXCOja5sAXYMIqEkB3ja
	 tReMpiMGkh3jA==
Date: Sat, 21 Mar 2026 19:13:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 03/14] iio: adc: add an article and use digitize
 instead of digitalize
Message-ID: <20260321191330.097e90b4@jic23-huawei>
In-Reply-To: <20260316090023.14691-4-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-4-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:11 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Use digitize instead of digitalize, which is the correct technical term,
> and add an article for clarity.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied,
Thanks,
J
