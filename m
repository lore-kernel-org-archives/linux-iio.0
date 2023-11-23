Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC12556C
	for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2023 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcYk6O3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5157CC433C7
	for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2023 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700766049;
	bh=G+Dy4KlYcqqYBCj5eeVSNK8u3FNeYXI5gL4OaSxXuA0=;
	h=Date:From:To:Subject:From;
	b=QcYk6O3W68QhBXNh3SmhIiXuc0jrFIrp1EaQ+7xlkVXLTyAtWJojSO4jw8zKZg+3U
	 c8e5jO+lRaoEBnr/+8w/f4XLC9uVGXvo2Fr5Nw+kdRUh2h5+rdivdLjw2FQwD0HD8l
	 YGCWMgoK8Y6sl7QMfqkCEtcOyf1MeHSE3wJ3Fyj7ozLRnMaUWUNL3j5+Ky5NvkZ8Un
	 hUjIA7Rof9T4ImpJfS9a3xe9A6Ck3oSQ3I6rXJW50kAgBGQqKTBWQfnDovJsvKY3xj
	 Ekf3XmM0qqgpppBDFKZMDHCd+zOK7CqL6ygRegc1diMmAtWANsOGF8pP4RMSykW+gy
	 0n/y/jt/3+9Jg==
Date: Thu, 23 Nov 2023 19:00:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Subject: IIO: Playing catch up.
Message-ID: <20231123190044.4fb992f1@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

Unfortunately I didn't get nearly as much time to do normal reviews etc in the
last few weeks due to travel and resulting day job pile up.  I'll catch up, but might
take a little while yet before we get back to normal target (I aim for within 2 weeks of
posting.)  It's early in the cycle so hopefully this shouldn't delay anything
too much!

Jonathan

p.s. LPC was fun/mad. Was great to meet some new people f2f - apologies for my terrible
memory for names!  Thoroughly recommend attending LPC at least once (I believe it's
in Europe next year)
