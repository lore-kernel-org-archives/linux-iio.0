Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169776;
	b=Kjg5vHCsfZ5TFY1QUUUq+1FYIoKc852IPif/BmcpYquFfIcsLorW0fXnEectJ3b6qARp
	 8VjbSVpXLOxQXagcHzRrH4W2PbDzEK9ECHQz8JkF8pa0ndQ47YLgtiDT3Jgv8o4NnAaZC
	 axIAgAPlKMuPe4buNtEW3AKFyWrACEz9h5IZK3F/VhUAQaBOH01QDHDIP6uPZa5q9eho+
	 biBJqEgXXjMEG3wrjtBlURiLUGettIVgK22i7rkT6ltv+RVjeRzF+OkeuuCje7kJezj8Y
	 zjA0/ExqPiWWYJGXcAa1ATwvry8wifMj9aaR4CiqDe402sclIjGDIrcgODaRWClqEdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169776;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b9zeEJKsszthQW+o0qMgTtRbFqeedc09AcTN1l4NUHI=;
	b=U4oOK0O212UO72d9W+VV5QBs8m1kmX5a94CdnGBou7hMnYWnrZfgDyBPWNlfqE6UwA1B
	 AuGiAb/Ddo7iIZ9kAq7Yx8kB3oX8TfWkXgttyIvNKkrqltCVc15OkgK8W3oOWOqYXWX1d
	 5n209teXAsJZXNbFMIzk6cXlfeLMLc/83fggwtttwPIzKsz8McEFqHImx1c9BdsNhjfSP
	 maT4UXkmtET1MxN8u6+n2ie65icusrewP4q5190OxrmCswQbj+pPuhk6AiFLZyio3I57g
	 Lxin3sVXhmfK78WHX3sl/VRJN6Rrzzaubqx8mmHIO3CAhae2LVOfw+/2EgpjZt8MEeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5zaIDeb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EE606A320
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5zaIDeb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBD1F0089F;
	Sun,  8 Nov 2026 20:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169775;
	bh=b9zeEJKsszthQW+o0qMgTtRbFqeedc09AcTN1l4NUHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X5zaIDebn+yiV0u0fFEuBqm/38MbnGexvRnPrcs62DH+gD2kMAdq9rQGNkfmjErZD
	 pgGQiDayEq03XFw7I2dWW0wr3iG9vDXQKbxnRYoEPVd44UcKfhS5JAUBXsJJ911yTR
	 WsPDMgCatLXNsFpOSU/fJj4pmRZTS37rzDt/dbau6TVCbkBhqrGOKGIPNdVnCL22Yt
	 +RXOHdoO6q6E2fi1QzlaRH6fGvpPGFjx0p+2Fs3aemp/VYDgpZq7DXvAK2sL8Qh+oh
	 WFj2L+zgfoAses28FmPgG9H/IXKuRMmnZhVAhz2Edj2O5W2Eb6O0qrXJ+FurvlebWB
	 pGsv16HRZ0wTQ==
Date: Sun, 8 Nov 2026 20:29:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 37/39] iio: common: ssp_sensors: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108202929.2aa282a0@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-37-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-37-8b136778eedf@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Mon, 26 Oct 2026 16:05:55 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied.
