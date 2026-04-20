Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF439FCBA;
	Mon, 20 Apr 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688208; cv=none; b=r2G2XmgA8YMYzW4Ax3Kv2c6oxdgo0Timfz/g4VzClpZmNvEFZBmIW1gS+VMJce/6qGeLivxjEYN5Mb1sTCCfyaiT3DvlcwhXXmp+MJuOuRG4d4kYKgOoMAfCzPIWktKB3AJefzjAod/C0ol8V7VlHtBERc0z3ANjTvS7WxyEztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688208; c=relaxed/simple;
	bh=nHtqJlnQN0AqByhVxUAAWUXTv6Apc9f5mgyT7e7i+eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAhT0x8HiBNMsWv2qPpzMIEuCl3d3a58u+d+BlLzKW28wePU/E6PtrE/pfBIcKYktA0y6aC/KhIAw4/luS3Jp2VKff5+NVBkbPW4wdBRax86a96wuh+l+bNeVmI1zDCbDW9OBaAP6EJbEl0PGq45jvKgXwhm/7t9nnikgM9EKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EcxjnNbZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EcxjnNbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA88C2BCB4;
	Mon, 20 Apr 2026 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776688207;
	bh=nHtqJlnQN0AqByhVxUAAWUXTv6Apc9f5mgyT7e7i+eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcxjnNbZov0tGOyq4NnI9KbqE3ji7A7FP0RX8c7lGc9t8VqycDWBCEoUh585j5Af3
	 yqnsf6A/cwzSC+8dDPN8pva+kpgMpbAXOIjcBq0qQhbqDiFGuXIfj4DOo9SjS6itZh
	 af1Mra8evblGdUjwUqfBumy+j7V4T2MQiLbZx2ps=
Date: Mon, 20 Apr 2026 14:30:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Minu Jin <s9430939@naver.com>
Cc: lars@metafoo.de, jic23@kernel.org, Michael.Hennerich@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7816: use sysfs_emit() instead of sprintf()
Message-ID: <2026042032-unbeaten-magnetism-677c@gregkh>
References: <20260420112720.1662703-1-s9430939@naver.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420112720.1662703-1-s9430939@naver.com>

On Mon, Apr 20, 2026 at 08:27:20PM +0900, Minu Jin wrote:
> Replace sprintf() with sysfs_emit().
> sysfs_emit() is preferred than sprintf() in show() functions.

For _new_ functions, not existing ones.

> It has aware of the PAGE_SIZE buffer limit and ensures safe buffer handling.

Are any of the current usages incorrect?  If not, no need to change
this.

thanks,

greg k-h
