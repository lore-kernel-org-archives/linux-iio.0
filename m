Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFF31327D;
	Thu,  9 Apr 2026 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742053; cv=none; b=nMwRyF/ggKIUMyFJxDsNDCF/HykVuzAR5ayLbLwzZNIdTrHcNsYK3DtmVBmK/kbvMoeWO88SXrkp9xUFGvPVBLmIGPXXUeFIqsbapem8DNegQi4cA8HxrVbQ6TCJDwRC+Nub+VlQq4GIJWG3wcSq/S/XnilmrWDO+OpkgRsjfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742053; c=relaxed/simple;
	bh=bnm6PNNbRbPaCyxln4y5oe9lF9XI/Z51cTMOZon79kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk9DJGNYfxpjf5zFBLO0oZLcdRcsaarnNAE2GaEsQcH2+JgJQLh7pFDYAfiflNnSH2/HnUPe7n2zzvKHZ74ppwbyrZPrYoYMBr97pntTcVKIDTY2wXZelOPt7id8pYyYUo0awA5fkzxgd56HVSpBefpZ2jhIlpSRCkqftrZlrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sT5oR4X8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sT5oR4X8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EF0C4CEF7;
	Thu,  9 Apr 2026 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775742052;
	bh=bnm6PNNbRbPaCyxln4y5oe9lF9XI/Z51cTMOZon79kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT5oR4X8jmJJYgzjT99nw8aoAVJQEk7aeGH0JIjCJ/iCgyy80qOKLCc2dltalNjEq
	 Bph2jjJWVphw08v++8+d+HpwTFOKbE5f1kmVba+Pv0c23e5FEQ5TfrIuFjWXhunmPg
	 tTZokl7abWtvG4JJp/UT92b/wQVggFumTuXITfxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 2/3] iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer
Date: Thu,  9 Apr 2026 15:40:48 +0200
Message-ID: <2026040949-ferment-reload-abcd@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040947-overhang-fax-02d0@gregkh>
References: <2026040947-overhang-fax-02d0@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=bnm6PNNbRbPaCyxln4y5oe9lF9XI/Z51cTMOZon79kg=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnX1yQ+NtEuTEmtDEt9ZnSR0S7s38265qeJRQ+ss3x/P H75a0FsRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkgg7DXIE/r6qZrI4uCbm0 qL5qVpNvsO5UH4b5UWdmRa56EmCw8UapV21RnN+FBf+uAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The tagged FIFO path declares iio_buff on the stack with __aligned(8)
but no initializer, but there is a hole in the structure, which will
then leak to userspace as ST_LSM6DSX_SAMPLE_SIZE bytes (6) will be
copied, but the space between that and the timestamp are not
initialized.

Commit c14edb4d0bdc ("iio:imu:st_lsm6dsx Fix alignment and data leak
issues") moved the untagged FIFO path to a kzalloc'd buffer in hw->scan,
but for the tagged path it only added the alignment qualifier and not
the initializer :(

Fix this by just zero-initializing the structure on the stack.

Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Fixes: c14edb4d0bdc ("iio:imu:st_lsm6dsx Fix alignment and data leak issues")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..48291203d1cd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -609,7 +609,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	 * must be passed a buffer that is aligned to 8 bytes so
 	 * as to allow insertion of a naturally aligned timestamp.
 	 */
-	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
+	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8) = { };
 	u8 tag;
 	bool reset_ts = false;
 	int i, err, read_len;
-- 
2.53.0

