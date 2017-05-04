Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33681 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdEDUiz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 16:38:55 -0400
From: Enric Balletbo i Serra <eballetbo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/2] tsl2x7x_core: remove paragraph about writing to the FSF's mailing address
Date: Thu,  4 May 2017 22:38:31 +0200
Message-Id: <20170504203832.5525-1-eballetbo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Do not include the paragraph about writing to the Free Software
Foundation's mailing address from the sample GPL notice. The FSF
has changed addresses in the past, and may do so again. Linux
already includes a copy of the GPL.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index ea15bc1c300c..b35ff63f7f60 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -13,10 +13,6 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA        02110-1301, USA.
  */
 
 #include <linux/kernel.h>
-- 
2.11.0

