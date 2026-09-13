Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B433BED30;
	Sun, 13 Sep 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338290; cv=none; b=qcehWog7MWdne3QpphG2/i8XjZr8qwVTr59oG2TjLkz0RL5lZYvZHFsl9naDgWAq9RNqJGvi2h9r+UX+IFGPRceuoK5QOdTjCs7jeYTSzNCdxTn2oDmlvOTF/7bVUCpcO4IDGok09WnWTFs/1M59TmOz+Fo0/Gfjil6v+LK4bFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338290; c=relaxed/simple;
	bh=dI+f8O9QJj9/7Win8a1o39BX41OjU3pzeerrRwwfN3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKqImUNgXfeeomdIjb1CIX0yekSZPniaDZKYiNKRZnkUUq6J32eWMnX+Lj73kamvU8Vwn0BZSnbRl/UXr/5JKCnTW1dBJFomqYUL9/h05sX1L5ZCiYe2eaZEQpFlcb7HBLBkUgDmm6ra3vCUaTXP2ZhFX2nRKzTnC9tiKrw313M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV+wix6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV+wix6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421261F000FF;
	Sun, 13 Sep 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338287;
	bh=dI+f8O9QJj9/7Win8a1o39BX41OjU3pzeerrRwwfN3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WV+wix6ymwJdIc7z2GCEV37buhwJoWDa4+AEQ1ypSF82SQZRw9nmcPFWUF0cJaP4b
	 zijRiY5BtkMpKUCKqTrjn1ArHbOMWtiuAHonNZQUUQtilPi79hlwZ8ToWt+FbRtZcg
	 tErA7DAWuaa1ay2JMKx74sOoc5a7XUonx1tW8QxMgJPihFknVl737SCq44o+vxxhWd
	 QqXxTdr0hGjrb+3kMky1q24r5JsRNaSbUHHCSAYzdvo7RO7ruzaly0QjX9DFbTaQnZ
	 ysqpG1XqO+4TUiG6xXUiYTmgjmydGFQ0S99tOUd5MeFI2pAmu/s3xJCmVQ0YXdg4l1
	 AuF9EdlnaVpww==
Date: Sun, 13 Sep 2026 23:24:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v9 0/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260913232440.42fc1e7d@jic23-hlaptop>
In-Reply-To: <20260907-veml6031x00-v9-0-8c93a6c66a4d@gmail.com>
References: <20260907-veml6031x00-v9-0-8c93a6c66a4d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 13:48:38 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These ambient light sensors with I2C interface provide two light
> channels (ALS and IR), high/low threshold alarms with configurable
> persistence, and a data ready signal.
Small process thing.

If you are going to send a new version of a series when there
has been nothing on the list yet, please send a quick reply
to make sure no one focuses on wrong version.

b4 review tui caught this for me when it asked if I really wanted
to look at an old version!

Jonathan
