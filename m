Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620337882A
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355747; cv=none; b=auPwce0nx5Fy5x3Fs2/2fZiaO3kM+riE9PMmo/QJ85Wbx/jmingfGexP+Xq1/FCQxCyZepsuuGFZ4aTIBtSA5PCGEGkBvIWQSbqDynogJb+Bua5soOxI5jPqpV0FqmApG/OTfut6QEtPxnhayck5KDFxwTGrjkr1Ki5VGm9P6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355747; c=relaxed/simple;
	bh=mPuEnH+ffr7fmAHDHmyen8xWHB6lE+yHTMmtODh86Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=awbhsY7GSfV96jtAPznh/ZeCcHOesMWg9hs8H4Am7V3VDFL12YrradAgiSdiHlJbuyAM6uM0bQUE1JKU0oJ9iD3ZydPqK2figym3bIaXJ85zx3dN047w/cAV7WztJp/MbSFgqfUsP/UxahmlBGcNG0dVybT1xuZFVgy2LhQiR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXZvQTw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXZvQTw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E211F000E9;
	Mon,  6 Jul 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783355745;
	bh=yQx0FXf661ULd8TgsdAG1MJL6rQ5N9WWwsa0Ge2vei4=;
	h=Date:From:To:Cc:Subject;
	b=lXZvQTw8oCZe4m3T/OKH0wSChV6qUWv5wf+1LX2On2mbHL2a0PoU3x5qiW2SMGohg
	 mCCmIxYMquN2UKDSur11tKOBp/KqOmM1TawK1tZU4d0IqSpxVKsuHi/q+RhM3T7YCl
	 xAEC213JA2yDoYITjlrXm/EKX8erTYD4fHw0LAThOYsTaLOtnPPlL2/yq+rqYox7Hp
	 vCZsxZObIQ8rUDPlVqGFepfJkpBudOLkMhp2xEfdR+CkNcIJlczZMHNX9F3NR25qF9
	 /LJs6Bf5v7RzbOIqJGspENRzCvA5A3Nl3WRrM04lTIaaVCsblAfaHxEc2Z05bmMzxK
	 /bX6FFdWy3chQ==
Date: Mon, 6 Jul 2026 17:35:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: IIO: Merged in v7.2-rc2 + anyone have comments on whether to ask
 for sashiko emails to the list?
Message-ID: <20260706173541.4f25ad81@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi All,

Note that I've just pushed the testing branch out with v7.2-rc2 merged
in.  There were 3 conflicts due to Uwe's work on restructuring the
headers for device_id tables.  Note I haven't (yet anyway) updated
the 7 additions of mod_devicetable.h that crossed with his patch set
as I didn't want to complicate the merge.

For new work this cycle please base either on v7.2-rc2 or on top of
my togreg branch (assuming no problems that will have this merge sometime
later this week). This should only make much difference for new drivers,
or for any IWYU / header improvement patches.

On another topic. Personally I'm reasonably impressed with Sashiko's
feedback. However it is far from perfect and I'm a little concerned
that new folk might not treat it with appropriate caution.

What do people feel about me asking them to enable sending replies 
directly to the list?

Thanks,

Jonathan
